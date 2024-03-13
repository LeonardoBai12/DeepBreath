import '../../data/remote/country_response.dart';

class Country {
  String code;
  String name;
  String lastUpdated;

  Country({
    required this.code,
    required this.name,
    required this.lastUpdated,
  });

  factory Country.fromCountryResponse(CountryResponse response) {
    return Country(
      code: response.code,
      name: response.name,
      lastUpdated: response.lastUpdated,
    );
  }
}
