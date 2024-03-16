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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: "/countries_screen",
          page: () => const CountriesScreen(),
          binding: CountriesBinding()
        ),
        GetPage(
          name: "/location_screen",
          page: () => const LocationScreen(),
          binding: LocationBinding()
        ),
        GetPage(
            name: "/location_details_screen",
            page: () => const LocationDetailsScreen(),
        ),
      ],
    );
  }
}
