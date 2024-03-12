import 'package:deepbreath/countries/data/remote/countries_remote_data_source.dart';
import 'package:deepbreath/countries/data/repository/countries_repository_impl.dart';
import 'package:deepbreath/countries/domain/repository/countries_repository.dart';
import 'package:deepbreath/countries/domain/use_cases/countries_use_cases.dart';
import 'package:deepbreath/countries/domain/use_cases/get_countries_use_case.dart';
import 'package:deepbreath/countries/domain/use_cases/get_country_details_use_case.dart';
import 'package:deepbreath/countries/presentation/countries_controller.dart';
import 'package:get/get.dart';

class CountriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountriesRemoteDataSource());
    Get.lazyPut<CountriesRepository>(() => CountriesRepositoryImpl(Get.find()));
    Get.lazyPut(() => CountriesUseCases(
        GetCountriesUseCase(Get.find()),
        GetCountryDetailsUseCase(Get.find())
    ));
    Get.lazyPut(() => CountriesController(Get.find()));
  }
}
