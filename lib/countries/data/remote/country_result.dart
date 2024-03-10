class CountryResult {
  String code;
  String name;
  String lastUpdated;

  CountryResult({
    required this.code,
    required this.name,
    required this.lastUpdated,
  });

  factory CountryResult.fromJson(Map<String, dynamic> json) {
    return CountryResult(
      code: json['code'],
      name: json['name'],
      lastUpdated: json['datetimeLast'],
    );
  }
}
