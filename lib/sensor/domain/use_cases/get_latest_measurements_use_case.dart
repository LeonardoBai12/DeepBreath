import 'package:deepbreath/sensor/domain/model/sensor_measurement.dart';
import 'package:deepbreath/sensor/domain/repository/sensor_repository.dart';

class GetLatestMeasurementsUseCase {
  final SensorRepository _repository;
  GetLatestMeasurementsUseCase(this._repository);

  Future<List<SensorMeasurement>> execute(int locationId) {
    return _repository.getLatestMeasurements(locationId);
  }
}
