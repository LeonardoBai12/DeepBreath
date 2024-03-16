class ParameterResponse {
  int id;
  String name;
  String unit;
  String displayName;
  double average;
  double lastValue;

  ParameterResponse({
    required this.id,
    required this.name,
    required this.unit,
    required this.displayName,
    required this.average,
    required this.lastValue,
  });

  factory ParameterResponse.fromJson(Map<String, dynamic> json) {
    return ParameterResponse(
      id: json['id'],
      name: json['parameter'],
      unit: json['unit'],
      displayName: json['displayName'],
      average: json['average'].toDouble(),
      lastValue: json['lastValue'].toDouble(),
    );
  }
}
