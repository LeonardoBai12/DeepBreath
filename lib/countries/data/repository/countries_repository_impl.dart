import 'package:deepbreath/countries/data/remote/country_response.dart';
import 'package:flutter/foundation.dart';
import 'package:deepbreath/utils/resource.dart';

import '../../domain/model/country.dart';
import '../../domain/repository/countries_repository.dart';
import '../remote/countries_remote_data_source.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource _dataSource;
  CountriesRepositoryImpl(this._dataSource);

  @override
  Stream<Resource<List<Country>>> getCountries() async* {
    yield Loading(true);

    try {
      List<CountryResponse> result = await _dataSource.getCountries();
      yield Success(
          result.map((result) => Country.fromCountryResponse(result)).toList()
      );
    } catch (e, st) {
      debugPrint('CountriesRepository error: $e\n$st');
      yield Error(e.toString());
    }

    yield Loading(false);
  }
}
