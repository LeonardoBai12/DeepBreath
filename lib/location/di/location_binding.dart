import 'package:deepbreath/location/domain/use_cases/get_location_by_country_id_use_case.dart';
import 'package:get/get.dart';

import '../data/remote/location_remote_data_source.dart';
import '../data/repository/location_repository_impl.dart';
import '../domain/repository/location_repository.dart';
import '../domain/use_cases/location_use_cases.dart';
import '../presentation/location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationRemoteDataSource());
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl(Get.find()));
    Get.lazyPut(() => LocationUseCases(
        GetLocationByCountryByIdUseCase(Get.find()),
    ));
    Get.lazyPut(() => LocationController(Get.find()));
  }
}
