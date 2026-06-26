import 'package:deepbreath/location/domain/model/location.dart';
import 'package:deepbreath/sensor/presentation/sensor_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/blur_effect.dart';
import '../../utils/theme.dart';
import '../domain/model/parameter.dart';
import '../util/string_helper.dart';

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({super.key});

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  late final Location _location;

  @override
  void initState() {
    super.initState();
    _location = Get.arguments["location"];
  }

  void _showSensorDialog(Parameter parameter) {
    showDialog(
      context: context,
      builder: (_) => SensorDialog(parameter: parameter, locationId: _location.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_location.name, style: DeepBreathTextStyles.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: DeepBreathColors.appBarBackground,
        flexibleSpace: const BlurEffect(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: DeepBreathPaddings.mainAllPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BadgesRow(location: _location),
                const SizedBox(height: 20),
                _SectionHeader(label: 'Station info'),
                const SizedBox(height: 8),
                _InfoCard(location: _location),
                const SizedBox(height: 20),
                _SectionHeader(label: 'Sensors'),
                const SizedBox(height: 4),
                Text(
                  'Tap a sensor to see its latest reading.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 8),
                _SensorsWrap(
                  parameters: _location.parameters,
                  onTap: _showSensorDialog,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: DeepBreathTextStyles.mediumHeader.copyWith(fontSize: 13)),
        const SizedBox(width: 8),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _BadgesRow extends StatelessWidget {
  const _BadgesRow({required this.location});
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _Badge(
          icon: location.isMobile ? Icons.directions_walk : Icons.location_on,
          label: location.isMobile ? 'Mobile station' : 'Fixed station',
          color: location.isMobile ? Colors.orange.shade700 : Colors.blue.shade700,
        ),
        _Badge(
          icon: location.isMonitor ? Icons.verified : Icons.sensors,
          label: location.isMonitor ? 'Official monitor' : 'Low-cost sensor',
          color: location.isMonitor ? Colors.green.shade700 : Colors.grey.shade600,
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.location});
  final Location location;

  @override
  Widget build(BuildContext context) {
    final hasCoords = location.latitude != null && location.longitude != null;
    final coordText = hasCoords
        ? '${location.latitude!.toStringAsFixed(4)}°, ${location.longitude!.toStringAsFixed(4)}°'
        : null;

    final dateRange = _buildDateRange(location.firstUpdated, location.lastUpdated);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (location.provider?.isNotEmpty == true)
            _InfoRow(icon: Icons.dataset_outlined, label: 'Provider', value: location.provider!),
          if (location.owner?.isNotEmpty == true)
            _InfoRow(icon: Icons.account_balance_outlined, label: 'Owner', value: location.owner!),
          if (location.instrument?.isNotEmpty == true)
            _InfoRow(icon: Icons.devices_other_outlined, label: 'Instrument', value: location.instrument!),
          if (location.timezone?.isNotEmpty == true)
            _InfoRow(icon: Icons.language_outlined, label: 'Timezone', value: location.timezone!),
          if (location.city?.isNotEmpty == true)
            _InfoRow(icon: Icons.location_city_outlined, label: 'City', value: location.city!),
          if (coordText != null)
            _InfoRow(icon: Icons.my_location_outlined, label: 'Coordinates', value: coordText),
          if (dateRange != null)
            _InfoRow(icon: Icons.date_range_outlined, label: 'Active period', value: dateRange, isLast: true),
        ],
      ),
    );
  }

  String? _buildDateRange(String first, String last) {
    final f = first.isNotEmpty ? transformDateFormat(first) : null;
    final l = last.isNotEmpty ? transformDateFormat(last) : null;
    if (f == null && l == null) return null;
    if (f != null && l != null) return '$f → $l';
    return f ?? l;
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 10),
              SizedBox(
                width: 80,
                child: Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
              ),
              Expanded(
                child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, indent: 40, endIndent: 14, color: Colors.grey.shade200),
      ],
    );
  }
}

class _SensorsWrap extends StatelessWidget {
  const _SensorsWrap({required this.parameters, required this.onTap});
  final List<Parameter> parameters;
  final void Function(Parameter) onTap;

  static Color colorFor(String name) {
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
    if (parameters.isEmpty) {
      return Text('No sensors available.', style: TextStyle(color: Colors.grey.shade500));
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: parameters.map((p) {
        final label = p.displayName.isNotEmpty ? p.displayName : p.name;
        final color = colorFor(p.name);
        return GestureDetector(
          onTap: () => onTap(p),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(
                  '$label · ${p.units}',
                  style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
