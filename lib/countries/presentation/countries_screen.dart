import 'package:deepbreath/location/presentation/location_screen.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../domain/model/country.dart';
import 'countries_controller.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late final CountriesController _countriesController;

  @override
  void initState() {
    super.initState();
    _countriesController = Get.find<CountriesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Expanded(
              child: FutureBuilder<List<Country>>(
                  future: _countriesController.getCountries(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Country> countries = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: countries.length,
                        itemBuilder: (context, index) {
                          Country country = countries[index];

                          if (country.code.isEmpty) {
                            return Column(
                              children: [
                                const Text(
                                    "No flag found on ISO 3166-1 alpha2 :(",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                Text(
                                  country.name,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }

                          return GestureDetector(
                              onTap: () {
                                Get.toNamed("/location_screen",
                                    arguments: {
                                      "country": country
                                    });
                              },
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 6
                                      ),
                                      child: Hero(
                                          tag: country,
                                          child: Flag.fromString(
                                            country.code,
                                            height: 60,
                                            width: 90,
                                            borderRadius: 12,
                                          )
                                      )
                                  ),
                                  Text(
                                    country.name,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                          );
                        },
                      );
                    }
                  }
              )
          )
      ),
    );
  }
}
