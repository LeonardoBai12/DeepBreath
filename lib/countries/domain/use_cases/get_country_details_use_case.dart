import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/countries/domain/repository/countries_repository.dart';
import 'package:deepbreath/utils/resource.dart';

class GetCountryDetailsUseCase {
  final CountriesRepository _repository;
  GetCountryDetailsUseCase(this._repository);

  Future<Stream<Resource<Country?>>> execute(String code) async {
    return _repository.getCountryDetails(code);
  }
}
