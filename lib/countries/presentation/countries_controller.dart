import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/countries/domain/use_cases/countries_use_cases.dart';
import 'package:get/get.dart';

class CountriesController extends GetxController {
  final CountriesUseCases _useCases;
  CountriesController(this._useCases);

  Future<List<Country>> getCountries() async {
    return await _useCases.getCountriesUseCase.execute();
  }
}
