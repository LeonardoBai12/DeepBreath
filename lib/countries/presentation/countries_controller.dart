import 'package:deepbreath/countries/domain/use_cases/countries_use_cases.dart';
import 'package:get/get.dart';

class CountriesController extends GetxController {
  final CountriesUseCases _useCases;
  CountriesController(this._useCases);
}
