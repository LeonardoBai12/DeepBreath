import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/countries/domain/use_cases/countries_use_cases.dart';
import 'package:get/get.dart';

class CountriesController extends GetxController {
  final CountriesUseCases _useCases;
  CountriesController(this._useCases);

  void getCountries() async {
    List<Country> result = await _useCases.getCountriesUseCase.execute();

    for (final country in result) {
      print('''code ${country.code} 
      name ${country.name}
      lastUpdated ${country.lastUpdated}''');
    }

    print(result.length);
  }
}
