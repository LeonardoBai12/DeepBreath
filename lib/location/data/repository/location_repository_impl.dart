import 'package:deepbreath/location/data/remote/location_remote_data_source.dart';
import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/location.dart';

import '../../domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _dataSource;

  LocationRepositoryImpl(this._dataSource);

  @override
  Future<List<Location>> getLocationByCountryCode(String code) async {
    List<LocationResponse> result = await _dataSource.getLocationsByCountryByCode(code);
    return result.map((result) => Location.fromLocationResponse(result)).toList();
  }
}
