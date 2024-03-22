import 'package:deepbreath/utils/resource.dart';

import '../model/country.dart';

abstract class CountriesRepository {
  Stream<Resource<List<Country>>> getCountries();
  Stream<Resource<Country?>> getCountryDetails(String code);
}
