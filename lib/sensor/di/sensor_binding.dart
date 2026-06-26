import 'package:deepbreath/sensor/data/remote/sensor_remote_data_source.dart';
import 'package:deepbreath/sensor/data/repository/sensor_repository_impl.dart';
import 'package:deepbreath/sensor/domain/repository/sensor_repository.dart';
import 'package:deepbreath/sensor/domain/use_cases/get_latest_measurements_use_case.dart';
import 'package:deepbreath/sensor/domain/use_cases/sensor_use_cases.dart';
import 'package:deepbreath/sensor/presentation/sensor_controller.dart';
import 'package:get/get.dart';

class SensorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SensorRemoteDataSource());
    Get.lazyPut<SensorRepository>(() => SensorRepositoryImpl(Get.find()));
    Get.lazyPut(() => SensorUseCases(GetLatestMeasurementsUseCase(Get.find())));
    Get.lazyPut(() => SensorController(Get.find()));
  }
}
