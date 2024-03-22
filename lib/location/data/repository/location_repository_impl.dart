import 'package:deepbreath/location/data/remote/location_remote_data_source.dart';
import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/location.dart';
import 'package:deepbreath/utils/resource.dart';

import '../../domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _dataSource;
  LocationRepositoryImpl(this._dataSource);

  @override
  Stream<Resource<List<Location>>> getLocationByCountryCode(String code) async* {
    yield Loading(true);

    try {
      List<LocationResponse> result = await _dataSource.getLocationsByCountryByCode(code);
      yield Success(
          result.map((result) =>
              Location.fromLocationResponse(result)
          ).toList()
      );
    } catch (e) {
      yield Error(e.toString());
    }

    yield Loading(false);
  }
}
