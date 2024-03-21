import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/utils/resource.dart';
import '../repository/countries_repository.dart';

class GetCountriesUseCase {
  final CountriesRepository _repository;
  GetCountriesUseCase(this._repository);

  Stream<Resource<List<Country>>> execute() {
    return _repository.getCountries();
  }
}
