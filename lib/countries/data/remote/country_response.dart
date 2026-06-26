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
      id: int.parse(json['id'].toString()),
      code: json['code'],
      name: json['name'],
      lastUpdated: json['datetimeLast'] is Map ? (json['datetimeLast']['utc'] as String? ?? '') : (json['datetimeLast'] as String? ?? ''),
    );
  }
}
