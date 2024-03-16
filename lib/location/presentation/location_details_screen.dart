import 'package:deepbreath/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/model/parameter.dart';

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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _location.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _location.parameters.length,
                itemBuilder: (context, index) {
                  Parameter parameter = _location.parameters[index];
                  return Column(
                    children: [
                      Text(parameter.name),
                      Text(parameter.displayName),
                    ],
                  );
                }
            )
          ],
        ),
    );
  }
}
