class ParameterResponse {
  int id;
  String name;
  String units;
  String displayName;

  ParameterResponse({
    required this.id,
    required this.name,
    required this.units,
    required this.displayName,
  });

  factory ParameterResponse.fromJson(Map<String, dynamic> json) {
    return ParameterResponse(
      id: json['id'],
      name: json['name'],
      units: json['units'],
      displayName: json['displayName'],
    );
  }
}
