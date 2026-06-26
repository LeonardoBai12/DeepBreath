import 'package:deepbreath/sensor/domain/model/sensor_measurement.dart';

abstract class SensorRepository {
  Future<List<SensorMeasurement>> getLatestMeasurements(int locationId);
}
