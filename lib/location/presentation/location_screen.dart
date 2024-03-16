import 'dart:ui';

import 'package:deepbreath/countries/domain/model/country.dart';
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

  @override
  void initState() {
    super.initState();
    _locationController = Get.find<LocationController>();
    _country = Get.arguments["country"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Row(
                    children: [
                      Hero(
                        tag: _country,
                        child: Flag.fromString(
                          _country.code,
                          height: 80,
                          width: 140,
                          borderRadius: 12,
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
                )
            ),
            Expanded(
              child:
              Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: FutureBuilder<List<Location>>(
                    future: _locationController.getLocationByCountryByCode(
                        _country.code
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Location> locations = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            Location location = locations[index];
                            return GestureDetector(
                                onTap: () {
                                  Get.toNamed("/location_details_screen",
                                      arguments: {
                                        "location": location
                                      });
                                },
                                child: Card(
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              location.name,
                                              textAlign: TextAlign.start,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Last time updated: ",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold
                                                  ),
                                                ),
                                                Text(
                                                  transformDateFormat(
                                                      location.lastUpdated
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    )
                                )
                            );
                          },
                        );
                      }
                    },
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
