import 'package:deepbreath/location/data/remote/latest_measurement_response.dart';

class LatestMeasurement {
  final double value;
  final String datetimeUtc;
  final int sensorId;

  LatestMeasurement({
    required this.value,
    required this.datetimeUtc,
    required this.sensorId,
  });

  factory LatestMeasurement.fromResponse(LatestMeasurementResponse r) {
    return LatestMeasurement(
      value: r.value,
      datetimeUtc: r.datetimeUtc,
      sensorId: r.sensorId,
    );
  }
}
