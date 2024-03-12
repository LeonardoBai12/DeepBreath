class ParameterResponse {
  String name;
  String units;
  String displayName;

  ParameterResponse({
    required this.name,
    required this.units,
    required this.displayName,
  });

  factory ParameterResponse.fromJson(Map<String, dynamic> json) {
    return ParameterResponse(
      name: json['name'],
      units: json['units'],
      displayName: json['displayName'],
    );
  }
}
