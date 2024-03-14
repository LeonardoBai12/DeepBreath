import 'package:deepbreath/location/data/remote/location_remote_data_source.dart';
import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/location.dart';

import '../../domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _dataSource;

  LocationRepositoryImpl(this._dataSource);

  @override
  Future<List<Location>> getLocationByCountryId(int countryId) async {
    List<LocationResponse> result = await _dataSource.getLocationsByCountryId(countryId);
    return result.map((result) => Location.fromLocationResponse(result)).toList();
  }
}
