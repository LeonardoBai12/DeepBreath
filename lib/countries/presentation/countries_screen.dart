import 'package:deepbreath/utils/error_view.dart';
import 'package:deepbreath/utils/theme.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/blur_effect.dart';
import '../../utils/resource.dart';
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
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _countriesController = Get.find<CountriesController>();
    _filteredCountries = [];
    _countries = [];
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final countriesStream = _countriesController.getCountries();

    await for (var resource in countriesStream) {
      if (resource is Success) {
        setState(() {
          _countries = (resource as Success).data;
          _filteredCountries = _countries;
        });
      } else if (resource is Error) {
        setState(() {
          _errorMessage = (resource as Error).message;
        });
      } else if (resource is Loading) {
        setState(() {
          _isLoading = (resource as Loading).isLoading;
        });
      }
    }
  }

  Future<void> _retry() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
      _countries = [];
      _filteredCountries = [];
    });
    await _loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "DeepBreath",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: DeepBreathColors.appBarBackground,
        flexibleSpace: const BlurEffect(),
      ),
      body: _errorMessage.isNotEmpty
          ? ErrorView(onRetry: _retry)
          : Stack(
              children: [
                SingleChildScrollView(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        child: _isLoading ? const Center(
                            heightFactor: 15,
                            child: CircularProgressIndicator()
                        ) : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 150),
                              Padding(
                                padding: DeepBreathPaddings.mainHorizontalPadding,
                                child: Text(
                                  'Tap a country to explore its air quality monitoring stations.',
                                  style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                                ),
                              ),
                              const SizedBox(height: 12),
                              CountriesGridView(
                                  filteredCountries: _filteredCountries
                              ),
                            ]
                        )
                    )
                ),
                SafeArea(
                    child: CountriesSearchBar(
                      countries: _countries,
                      onSearch: (filteredCountries) {
                        setState(() {
                          _filteredCountries = filteredCountries;
                        });
                      },
                    )
                )
              ]
          ),
    );
  }
}

class CountriesGridView extends StatelessWidget {
  const CountriesGridView({
    super.key,
    required List<Country> filteredCountries,
  }) : _filteredCountries = filteredCountries;

  final List<Country> _filteredCountries;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: DeepBreathPaddings.smallHorizontalPadding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        return GestureDetector(
          onTap: () => Get.toNamed("/location_screen", arguments: {"country": country}),
          child: CountryItem(country: country),
        );
      },
    );
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: DeepBreathPaddings.smallBottomPadding,
          child: Hero(
            tag: country,
            child: Flag.fromString(
              country.code,
              height: 69,
              width: 92,
              borderRadius: 4,
            ),
          ),
        ),
        Flexible(
          child: Text(
            country.name,
            textAlign: TextAlign.center,
            style: DeepBreathTextStyles.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
