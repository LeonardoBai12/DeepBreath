import 'package:deepbreath/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({super.key});

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  late final Location _location;

  @override
  void initState() {
    super.initState();
    _location = Get.arguments["location"];
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
            Text(_location.name),
            Text(_location.name),
            Text(_location.name),
          ],
        ),
      ),
    );
  }
}
