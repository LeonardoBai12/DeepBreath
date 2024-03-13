import 'package:deepbreath/countries/data/remote/country_response.dart';

import '../../domain/model/country.dart';
import '../../domain/repository/countries_repository.dart';
import '../remote/countries_remote_data_source.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource _dataSource;
  CountriesRepositoryImpl(this._dataSource);

  @override
  Future<List<Country>> getCountries() async {
    List<CountryResponse> result = await _dataSource.getCountries();
    return result.map((result) => Country.fromCountryResponse(result)).toList();
  }

  @override
  Future<Country?> getCountryDetails(String code) async {
    CountryResponse? result = await _dataSource.getCountryDetails(code);
    if (result == null) {
      return null;
    }
    return Country.fromCountryResponse(result);
  }
}
