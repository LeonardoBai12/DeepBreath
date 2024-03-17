import '../model/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocationByCountryCode(String code);
}
