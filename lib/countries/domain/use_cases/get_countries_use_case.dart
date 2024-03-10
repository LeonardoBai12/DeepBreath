import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:flutter/foundation.dart';
import '../repository/countries_repository.dart';

class GetCountriesUseCase {
  final CountriesRepository _repository;
  GetCountriesUseCase(this._repository);

  Future<List<Country>> execute() async {
    List<Country> result;
    try {
      result = await _repository.getCountries();
    } on Exception  catch (e) {
      if (kDebugMode) {
        print("Couldn't get countries. Error: \n $e");
      }
      result = List.empty();
    }

    return result;
  }
}
