import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../domain/model/location.dart';
import '../domain/use_cases/location_use_cases.dart';

class LocationController extends GetxController {
  final LocationUseCases _useCases;
  LocationController(this._useCases);

  Future<List<Location>> getLocationByCountryById(int countryId) async {
    return await _useCases.getLocationByCountryByIdUseCase.execute(countryId);
  }
}
