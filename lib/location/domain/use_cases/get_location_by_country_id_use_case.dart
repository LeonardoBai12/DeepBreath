import 'package:deepbreath/location/domain/repository/location_repository.dart';
import 'package:deepbreath/utils/resource.dart';
import 'package:flutter/foundation.dart';

import '../model/location.dart';

class GetLocationByCountryByIdUseCase {
  final LocationRepository _repository;
  GetLocationByCountryByIdUseCase(this._repository);

  Stream<Resource<List<Location>>> execute(String code)  {
    return _repository.getLocationByCountryCode(code);
  }
}
