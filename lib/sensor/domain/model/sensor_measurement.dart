import 'package:deepbreath/sensor/data/remote/sensor_measurement_response.dart';

class SensorMeasurement {
  final double value;
  final String datetimeUtc;
  final int sensorId;

  SensorMeasurement({required this.value, required this.datetimeUtc, required this.sensorId});

  factory SensorMeasurement.fromResponse(SensorMeasurementResponse r) {
    return SensorMeasurement(value: r.value, datetimeUtc: r.datetimeUtc, sensorId: r.sensorId);
  }
}
