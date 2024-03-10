import 'package:deepbreath/countries/domain/model/country.dart';
import '../repository/countries_repository.dart';
import 'dart:html';

class GetCountriesUseCase {
  final CountriesRepository _repository;
  GetCountriesUseCase(this._repository);

  Future<List<Country>> execute() async {
    List<Country> result;
    try {
      result = await _repository.getCountries();
    } on Exception  catch (e) {
      window.console.error("Couldn't get countries. Error: \n $e");
      result = List.empty();
    }

    return result;
  }
}
