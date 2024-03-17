class CountryResponse {
  String code;
  String name;
  String lastUpdated;

  CountryResponse({
    required this.code,
    required this.name,
    required this.lastUpdated,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      code: json['code'],
      name: json['name'],
      lastUpdated: json['lastUpdated'],
    );
  }
}
