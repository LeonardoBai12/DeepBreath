class LatestMeasurementResponse {
  final double value;
  final String datetimeUtc;
  final int sensorId;

  LatestMeasurementResponse({
    required this.value,
    required this.datetimeUtc,
    required this.sensorId,
  });

  factory LatestMeasurementResponse.fromJson(Map<String, dynamic> json) {
    return LatestMeasurementResponse(
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      datetimeUtc: (json['datetime'] as Map<String, dynamic>?)?['utc'] as String? ?? '',
      sensorId: json['sensorsId'] as int? ?? 0,
    );
  }
}
