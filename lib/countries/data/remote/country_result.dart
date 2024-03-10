class CountryResult {
  String code;
  String name;
  int locations;
  String lastUpdated;
  int cities;

  CountryResult({
    required this.code,
    required this.name,
    required this.locations,
    required this.lastUpdated,
    required this.cities,
  });

  factory CountryResult.fromJson(Map<String, dynamic> json) {
    return CountryResult(
      code: json['code'],
      name: json['name'],
      locations: json['locations'],
      lastUpdated: json['lastUpdated'],
      cities: json['cities'],
    );
  }
}
