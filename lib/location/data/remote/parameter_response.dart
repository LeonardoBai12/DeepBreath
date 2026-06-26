class ParameterResponse {
  int sensorId;
  int id;
  String name;
  String unit;
  String displayName;

  ParameterResponse({
    required this.sensorId,
    required this.id,
    required this.name,
    required this.unit,
    required this.displayName,
  });

  factory ParameterResponse.fromJson(Map<String, dynamic> json) {
    final parameter = json['parameter'] as Map<String, dynamic>? ?? json;
    return ParameterResponse(
      sensorId: json['id'] as int? ?? 0,
      id: parameter['id'] as int? ?? 0,
      name: parameter['name'] as String? ?? '',
      unit: parameter['units'] as String? ?? '',
      displayName: parameter['displayName'] as String? ?? parameter['name'] as String? ?? '',
    );
  }
}
