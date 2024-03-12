import 'get_countries_use_case.dart';
import 'get_country_details_use_case.dart';

class CountriesUseCases {
  final GetCountriesUseCase getCountriesUseCase;
  final GetCountryDetailsUseCase getCountryDetailsUseCase;
  CountriesUseCases(this.getCountriesUseCase, this.getCountryDetailsUseCase);
}
