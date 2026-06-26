import 'package:deepbreath/location/domain/model/latest_measurement.dart';
import 'package:deepbreath/location/domain/repository/location_repository.dart';

class GetLatestMeasurementsUseCase {
  final LocationRepository _repository;
  GetLatestMeasurementsUseCase(this._repository);

  Future<List<LatestMeasurement>> execute(int locationId) {
    return _repository.getLatestMeasurements(locationId);
  }
}
