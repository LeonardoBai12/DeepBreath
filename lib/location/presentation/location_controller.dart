import 'package:deepbreath/utils/resource.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../domain/model/latest_measurement.dart';
import '../domain/model/location.dart';
import '../domain/use_cases/location_use_cases.dart';

class LocationController extends GetxController {
  final LocationUseCases _useCases;
  LocationController(this._useCases);

  Stream<Resource<List<Location>>> getLocationsByCountryId(int countryId) {
    return _useCases.getLocationByCountryByCodeUseCase.execute(countryId);
  }

  Future<List<LatestMeasurement>> getLatestMeasurements(int locationId) {
    return _useCases.getLatestMeasurementsUseCase.execute(locationId);
  }
}
