import 'package:deepbreath/location/domain/use_cases/get_latest_measurements_use_case.dart';
import 'package:deepbreath/location/domain/use_cases/get_location_by_country_id_use_case.dart';

class LocationUseCases {
  final GetLocationByCountryByIdUseCase getLocationByCountryByCodeUseCase;
  final GetLatestMeasurementsUseCase getLatestMeasurementsUseCase;

  LocationUseCases(
    this.getLocationByCountryByCodeUseCase,
    this.getLatestMeasurementsUseCase,
  );
}
