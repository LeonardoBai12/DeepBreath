import 'package:deepbreath/location/domain/model/parameter.dart';
import 'package:deepbreath/location/util/string_helper.dart';
import 'package:deepbreath/sensor/domain/model/sensor_measurement.dart';
import 'package:deepbreath/sensor/presentation/sensor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SensorDialog extends StatefulWidget {
  const SensorDialog({super.key, required this.parameter, required this.locationId});
  final Parameter parameter;
  final int locationId;

  @override
  State<SensorDialog> createState() => _SensorDialogState();
}

class _SensorDialogState extends State<SensorDialog> {
  final SensorController _controller = Get.find<SensorController>();
  List<SensorMeasurement>? _measurements;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      final data = await _controller.getLatestMeasurements(widget.locationId);
      if (mounted) setState(() => _measurements = data);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  static Color _colorFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('pm')) return Colors.orange.shade700;
    if (n.contains('no')) return Colors.red.shade600;
    if (n.contains('o3') || n == 'ozone') return Colors.blue.shade600;
    if (n.contains('co')) return Colors.yellow.shade800;
    if (n.contains('so')) return Colors.purple.shade600;
    if (n.contains('temp')) return Colors.green.shade600;
    if (n.contains('humid') || n.contains('rh')) return Colors.lightBlue.shade600;
    return Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.parameter.displayName.isNotEmpty
        ? widget.parameter.displayName
        : widget.parameter.name;
    final color = _colorFor(widget.parameter.name);

    SensorMeasurement? match;
    if (_measurements != null) {
      try {
        match = _measurements!.firstWhere((m) => m.sensorId == widget.parameter.sensorId);
      } catch (_) {}
    }

    return AlertDialog(
      title: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
      content: _buildContent(match, color),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }

  Widget _buildContent(SensorMeasurement? match, Color color) {
    if (_error != null) {
      return Text('Could not load latest reading.', style: TextStyle(color: Colors.grey.shade600));
    }
    if (_measurements == null) {
      return const SizedBox(height: 64, child: Center(child: CircularProgressIndicator()));
    }
    if (match == null) {
      return Text('No recent reading available.', style: TextStyle(color: Colors.grey.shade600));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${match.value} ${widget.parameter.units}',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 6),
        Text(transformDateFormat(match.datetimeUtc), style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
      ],
    );
  }
}
