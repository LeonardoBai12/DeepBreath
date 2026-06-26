class ParameterResponse {
  int id;
  String name;
  String unit;
  String displayName;

  ParameterResponse({
    required this.id,
    required this.name,
    required this.unit,
    required this.displayName,
  });

  factory ParameterResponse.fromJson(Map<String, dynamic> json) {
    final parameter = json['parameter'] as Map<String, dynamic>? ?? json;
    return ParameterResponse(
      id: parameter['id'] ?? json['id'] ?? 0,
      name: parameter['name'] ?? '',
      unit: parameter['units'] ?? '',
      displayName: parameter['displayName'] ?? parameter['name'] ?? '',
    );
  }
}
