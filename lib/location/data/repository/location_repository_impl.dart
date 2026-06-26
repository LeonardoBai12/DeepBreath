import 'package:deepbreath/location/data/remote/location_remote_data_source.dart';
import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/location.dart';
import 'package:deepbreath/utils/resource.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _dataSource;
  LocationRepositoryImpl(this._dataSource);

  @override
  Stream<Resource<List<Location>>> getLocationsByCountryId(int countryId) async* {
    yield Loading(true);

    try {
      List<LocationResponse> result = await _dataSource.getLocationsByCountryId(countryId);
      yield Success(
          result.map((r) => Location.fromLocationResponse(r)).toList()
      );
    } catch (e, st) {
      debugPrint('LocationRepository error: $e\n$st');
      yield Error(e.toString());
    }

    yield Loading(false);
  }
}
