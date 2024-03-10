import '../../data/remote/country_result.dart';

class Country {
  String code;
  String name;
  int locations;
  String lastUpdated;
  int cities;

  Country({
    required this.code,
    required this.name,
    required this.locations,
    required this.lastUpdated,
    required this.cities,
  });

  factory Country.fromCountryResult(CountryResult countryResult) {
    return Country(
      code: countryResult.code,
      name: countryResult.name,
      locations: countryResult.locations,
      lastUpdated: countryResult.lastUpdated,
      cities: countryResult.cities,
    );
  }
}
