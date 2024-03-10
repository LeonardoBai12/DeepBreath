import '../../domain/model/country.dart';

class CountriesRemoteDataSource {
  Future<List<Country>> getCountries() async {
    return List.empty();
  }
  Future<Country?> getCountryDetails(String code) async {
    return null;
  }
}
