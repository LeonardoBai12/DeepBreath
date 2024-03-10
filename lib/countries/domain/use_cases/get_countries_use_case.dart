import 'package:deepbreath/countries/domain/model/country.dart';

import '../repository/countries_repository.dart';

class GetCountriesUseCase {
  final CountriesRepository _repository;
  GetCountriesUseCase(this._repository);

  Future<List<Country>> execute() async {
    return await _repository.getCountries();
  }
}
