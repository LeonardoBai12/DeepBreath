import '../model/country.dart';

abstract class CountriesRepository {
  Future<List<Country>> getCountries();
  Future<Country?> getCountryDetails(String code);
}
