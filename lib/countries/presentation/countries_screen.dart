import 'package:deepbreath/location/presentation/location_screen.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/countries_search_bar.dart';
import '../domain/model/country.dart';
import 'countries_controller.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late final CountriesController _countriesController;
  late List<Country> _filteredCountries;
  late List<Country> _countries;

  @override
  void initState() {
    super.initState();
    _countriesController = Get.find<CountriesController>();
    _filteredCountries = [];
    _countries = [];
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final countries = await _countriesController.getCountries();
    setState(() {
      _countries = countries;
      _filteredCountries = _countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DeepBreath",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              CountriesSearchBar(
                countries: _countries,
                onSearch: (filteredCountries) {
                  setState(() {
                    _filteredCountries = filteredCountries;
                  });
                },
              ),

              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index) {
                  Country country = _filteredCountries[index];

                  return GestureDetector(
                      onTap: () {
                        Get.toNamed("/location_screen",
                            arguments: {
                              "country": country
                            });
                      },
                      child: CountryItem(country: country)
                  );
                },
              )
            ]
        ),
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem({
    super.key,
    required this.country,
  });

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            )
        )
      ],
    );
  }
}
