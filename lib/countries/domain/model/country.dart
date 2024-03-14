import '../../data/remote/country_response.dart';

class Country {
  int id;
  String code;
  String name;
  String lastUpdated;

  Country({
    required this.id,
    required this.code,
    required this.name,
    required this.lastUpdated,
  });

  factory Country.fromCountryResponse(CountryResponse response) {
    return Country(
      id: response.id,
      code: response.code,
      name: response.name,
      lastUpdated: response.lastUpdated,
    );
  }
}
