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

  factory Country.fromCountryResult(CountryResponse countryResult) {
    return Country(
      code: countryResult.code,
      name: countryResult.name,
      lastUpdated: countryResult.lastUpdated,
    );
  }
}
