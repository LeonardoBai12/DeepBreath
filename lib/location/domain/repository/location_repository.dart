import '../model/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocationByCountryId(int countryId);
}
