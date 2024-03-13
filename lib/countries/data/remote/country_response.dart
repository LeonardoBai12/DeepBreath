class CountryResponse {
  int id;
  String code;
  String name;
  String lastUpdated;

  CountryResponse({
    required this.id,
    required this.code,
    required this.name,
    required this.lastUpdated,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      lastUpdated: json['datetimeLast'],
    );
  }
}
