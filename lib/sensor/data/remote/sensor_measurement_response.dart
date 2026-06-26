class SensorMeasurementResponse {
  final double value;
  final String datetimeUtc;
  final int sensorId;

  SensorMeasurementResponse({required this.value, required this.datetimeUtc, required this.sensorId});

  factory SensorMeasurementResponse.fromJson(Map<String, dynamic> json) {
    return SensorMeasurementResponse(
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      datetimeUtc: (json['datetime'] as Map<String, dynamic>?)?['utc'] as String? ?? '',
      sensorId: json['sensorsId'] as int? ?? 0,
    );
  }
}
