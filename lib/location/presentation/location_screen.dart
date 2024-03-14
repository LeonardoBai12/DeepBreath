import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/model/location.dart';
import 'location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = Get.find<LocationController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Expanded(
              child: FutureBuilder<List<Location>>(
                  future: _locationController.getLocationByCountryById(45),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Location> locations = snapshot.data!;
                      return ListView.builder(
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          Location location = locations[index];
                          return Column(
                            children: [
                              Text(location.name),
                              Text(location.datetimeLast),
                            ],
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
