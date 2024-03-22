import 'package:deepbreath/utils/resource.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../domain/model/location.dart';
import '../domain/use_cases/location_use_cases.dart';

class LocationController extends GetxController {
  final LocationUseCases _useCases;
  LocationController(this._useCases);

  Stream<Resource<List<Location>>> getLocationByCountryByCode(String code) {
    return _useCases.getLocationByCountryByCodeUseCase.execute(code);
  }
}
