import 'package:deepbreath/utils/resource.dart';

import '../model/location.dart';

abstract class LocationRepository {
  Stream<Resource<List<Location>>> getLocationByCountryCode(String code);
}
