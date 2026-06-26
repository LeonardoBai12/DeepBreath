import 'package:deepbreath/utils/resource.dart';

import '../model/latest_measurement.dart';
import '../model/location.dart';

abstract class LocationRepository {
  Stream<Resource<List<Location>>> getLocationsByCountryId(int countryId);
  Future<List<LatestMeasurement>> getLatestMeasurements(int locationId);
}
