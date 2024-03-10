import '../../domain/model/country.dart';
import '../../domain/repository/countries_repository.dart';
import '../remote/countries_remote_data_source.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource _dataSource;
  CountriesRepositoryImpl(this._dataSource);

  @override
  Future<List<Country>> getCountries() async {
    return _dataSource.getCountries();
  }
  @override
  Future<Country?> getCountryDetails(String code) async {
    return _dataSource.getCountryDetails(code);
  }
}
