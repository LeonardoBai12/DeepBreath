import 'package:deepbreath/sensor/data/remote/sensor_remote_data_source.dart';
import 'package:deepbreath/sensor/domain/model/sensor_measurement.dart';
import 'package:deepbreath/sensor/domain/repository/sensor_repository.dart';
import 'package:flutter/foundation.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorRemoteDataSource _dataSource;
  SensorRepositoryImpl(this._dataSource);

  @override
  Future<List<SensorMeasurement>> getLatestMeasurements(int locationId) async {
    try {
      final responses = await _dataSource.getLatestMeasurements(locationId);
      return responses.map((r) => SensorMeasurement.fromResponse(r)).toList();
    } catch (e, st) {
      debugPrint('SensorRepository error: $e\n$st');
      rethrow;
    }
  }
}
