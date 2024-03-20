import 'dart:ui';

import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/location/util/location_search_bar.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    super.initState();
    _locationController = Get.find<LocationController>();
    _country = Get.arguments["country"];
    _filteredLocations = [];
    _locations = [];
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final locations = await _locationController.getLocationByCountryByCode(
        _country.code
    );
    setState(() {
      _locations = locations;
      _filteredLocations = _locations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            children: [
              Hero(
                tag: _country,
                child: Flag.fromString(
                  _country.code,
                  height: 30,
                  width: 60,
                  borderRadius: 8,
                ),
              ),
              Flexible(
                  child: Text(
                    _country.name,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  )
              )
            ]
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              children: [
                LocationSearchBar(
                  locations: _locations,
                  onSearch: (filteredLocation) {
                    setState(() {
                      _filteredLocations = filteredLocation;
                    });
                  },
                ),

                Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: ListView.builder(
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
                                child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: LocationItem(location: location)
                                )
                            )
                        );
                      },
                    )
                ),
              ]
          )
      ),
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
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        location.city != null ?
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "City: ",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                location.city!,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16),
              )
            ]
        ) : const SizedBox(),
        const Text(
          "Last time updated: ",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
          transformDateFormat(location.lastUpdated),
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
