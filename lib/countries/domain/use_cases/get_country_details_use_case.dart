import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/countries/domain/repository/countries_repository.dart';

class GetCountryDetailsUseCase {
  final CountriesRepository _repository;
  GetCountryDetailsUseCase(this._repository);

  Future<Country?> execute(String code) async {
    return await _repository.getCountryDetails(code);
  }
}
