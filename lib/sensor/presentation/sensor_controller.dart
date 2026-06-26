import 'package:deepbreath/sensor/domain/model/sensor_measurement.dart';
import 'package:deepbreath/sensor/domain/use_cases/sensor_use_cases.dart';
import 'package:get/get.dart';

class SensorController extends GetxController {
  final SensorUseCases _useCases;
  SensorController(this._useCases);

  Future<List<SensorMeasurement>> getLatestMeasurements(int locationId) {
    return _useCases.getLatestMeasurementsUseCase.execute(locationId);
  }
}
