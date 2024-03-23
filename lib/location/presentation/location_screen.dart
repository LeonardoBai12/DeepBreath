import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/location/util/location_search_bar.dart';
import 'package:deepbreath/utils/resource.dart';
import 'package:deepbreath/utils/theme.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/blur_effect.dart';
import '../domain/model/location.dart';
import '../util/string_helper.dart';
import 'location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationController _locationController;
  late final Country _country;
  late List<Location> _filteredLocations;
  late List<Location> _locations;
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _locationController = Get.find<LocationController>();
    _country = Get.arguments["country"];
    _filteredLocations = [];
    _locations = [];
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final locationsStream = _locationController.getLocationByCountryByCode(
        _country.code
    );

    await for (var resource in locationsStream) {
      if (resource is Success) {
        setState(() {
          _locations = (resource as Success).data;
          _filteredLocations = _locations;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: LocationsAppBarTitle(country: _country),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: DeepBreathColors.appBarBackground,
          flexibleSpace: const BlurEffect(),
        ),
        body: Stack(
            children: [
              SingleChildScrollView(
                  child: Builder(
                      builder: (context) {
                        if (_errorMessage.isNotEmpty) {
                          return LocationsErrorMessage(
                              errorMessage: _errorMessage);
                        }

                        return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _isLoading ? const Center(
                                heightFactor: 15,
                                child: CircularProgressIndicator()
                            ) : Column(
                                children: [
                                  const SizedBox(height: 65),

                                  Padding(
                                    padding: DeepBreathPaddings
                                        .smallHorizontalPadding,
                                    child: LocationsListView(
                                        filteredLocations: _filteredLocations
                                    ),
                                  ),
                                ]
                            )
                        );
                      }
                  )
              ),

              SafeArea(
                child: LocationSearchBar(
                  locations: _locations,
                  onSearch: (filteredLocation) {
                    setState(() {
                      _filteredLocations = filteredLocation;
                    });
                  },
                ),
              )
            ]
        )
    );
  }
}

class LocationsListView extends StatelessWidget {
  const LocationsListView({
    super.key,
    required List<Location> filteredLocations,
  }) : _filteredLocations = filteredLocations;

  final List<Location> _filteredLocations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _filteredLocations.length,
      itemBuilder: (context, index) {
        Location location = _filteredLocations[index];
        return GestureDetector(
            onTap: () {
              Get.toNamed(
                  "/location_details_screen",
                  arguments: { "location": location}
              );
            },
            child: Card(
                shadowColor: Colors.transparent,
                surfaceTintColor: DeepBreathColors.cardBackground,
                shape: DeepBreathTextShapes.cardBorder,
                child: Padding(
                    padding: DeepBreathPaddings.mainAllPadding,
                    child: LocationItem(location: location)
                )
            )
        );
      },
    );
  }
}

class LocationsErrorMessage extends StatelessWidget {
  const LocationsErrorMessage({
    super.key,
    required String errorMessage,
  }) : _errorMessage = errorMessage;

  final String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: DeepBreathPaddings.mainAllPadding,
        child: Text(
            _errorMessage,
            style: DeepBreathTextStyles.subtitle
        )
    );
  }
}

class LocationsAppBarTitle extends StatelessWidget {
  const LocationsAppBarTitle({
    super.key,
    required Country country,
  }) : _country = country;

  final Country _country;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Padding(
            padding: DeepBreathPaddings.mainEndPadding,
            child: Hero(
              tag: _country,
              child: Flag.fromString(
                _country.code,
                height: 30,
                width: 40,
                borderRadius: 4,
              ),
            ),
          ),
          Flexible(
              child: Text(
                _country.name,
                style: DeepBreathTextStyles.title,
              )
          )
        ]
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start,
      children: [
        Text(
          location.name,
          textAlign: TextAlign.start,
          style: DeepBreathTextStyles.subtitle
        ),
        location.city?.trim().isNotEmpty == true ?
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "City: ",
                textAlign: TextAlign.start,
                style: DeepBreathTextStyles.mediumHeader,
              ),
              Text(
                location.city!,
                textAlign: TextAlign.start,
                style: DeepBreathTextStyles.bigCaption
              )
            ]
        ) : const SizedBox(),
        const Text(
          "Last time updated: ",
          textAlign: TextAlign.start,
          style: DeepBreathTextStyles.mediumHeader,
        ),
        Text(
          transformDateFormat(location.lastUpdated),
          textAlign: TextAlign.start,
          style: DeepBreathTextStyles.bigCaption
        ),
      ],
    );
  }
}
