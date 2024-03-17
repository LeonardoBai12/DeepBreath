import 'package:deepbreath/location/domain/repository/location_repository.dart';
import 'package:flutter/foundation.dart';

import '../model/location.dart';

class GetLocationByCountryByIdUseCase {
  final LocationRepository _repository;
  GetLocationByCountryByIdUseCase(this._repository);

  Future<List<Location>> execute(String code) async {
    List<Location> result;
    try {
      result = await _repository.getLocationByCountryCode(code);
    } on Exception  catch (e) {
      if (kDebugMode) {
        print("Couldn't get locations. Error: \n $e");
      }
      result = List.empty();
    }

    return result;
  }
}
