import 'package:deepbreath/location/di/location_binding.dart';
import 'package:deepbreath/location/presentation/location_details_screen.dart';
import 'package:deepbreath/location/presentation/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'countries/di/countries_binding.dart';
import 'countries/domain/model/country.dart';
import 'countries/presentation/countries_screen.dart';

void main() {
  runApp(const DeepBreathApp());
}

class DeepBreathApp extends StatelessWidget {
  const DeepBreathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/countries_screen",
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
            name: "/countries_screen",
            page: () => const CountriesScreen(),
            transition: Transition.fadeIn,
            binding: CountriesBinding()
        ),
        GetPage(
            name: "/location_screen",
            page: () => const LocationScreen(),
            transition: Transition.fadeIn,
            binding: LocationBinding()
        ),
        GetPage(
          name: "/location_details_screen",
          transition: Transition.cupertino,
          page: () => const LocationDetailsScreen(),
        ),
      ],
    );
  }
}
