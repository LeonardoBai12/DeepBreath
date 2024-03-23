import 'package:deepbreath/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/blur_effect.dart';
import '../domain/model/parameter.dart';
import '../util/string_helper.dart';

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
    var size = MediaQuery
        .of(context)
        .size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: LocationDetailsTitle(location: _location),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white.withAlpha(200),
          flexibleSpace: const BlurEffect(),
        ),
        body: Stack(
            children: [
              SingleChildScrollView(
                  child:
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocationData(location: _location, size: size),
                        ParametersGridView(
                            itemWidth: itemWidth,
                            itemHeight: itemHeight,
                            location: _location
                        ),
                      ],
                    ),
                  )
              ),
            ]
        )
    );
  }
}

class LocationDetailsTitle extends StatelessWidget {
  const LocationDetailsTitle({
    super.key,
    required Location location,
  }) : _location = location;

  final Location _location;

  @override
  Widget build(BuildContext context) {
    return Text(
      _location.name,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:  24
      ),
    );
  }
}

class ParametersGridView extends StatelessWidget {
  const ParametersGridView({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    required Location location,
  }) : _location = location;

  final double itemWidth;
  final double itemHeight;
  final Location _location;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: _location.parameters.length,
            itemBuilder: (context, index) {
              Parameter parameter = _location.parameters[index];
              return ParameterItem(parameter: parameter);
            }
        )
    );
  }
}

class LocationData extends StatelessWidget {
  const LocationData({
    super.key,
    required Location location,
    required this.size,
  }) : _location = location;

  final Location _location;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _location.city?.trim().isNotEmpty == true ?
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "City: ",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      _location.city ?? "",
                      style: const TextStyle(fontSize: 16),
                    )
                  ]
              ) : SizedBox(width: size.width),
              const Text(
                "Sensor manufacturer: ",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                _location.sensorManufacturer,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
              const Text(
                "Sensor model: ",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                _location.sensorModel,
                style: const TextStyle(
                    fontSize: 16
                ),
              )
            ]
        )
    );
  }
}

class ParameterItem extends StatelessWidget {
  const ParameterItem({
    super.key,
    required this.parameter,
  });

  final Parameter parameter;

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.transparent,
        surfaceTintColor: const Color(0xFF505050),
        shape: const RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0x0D000000)),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parameter.displayName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                const Text(
                  "Average: ",
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "${parameter.average.toStringAsFixed(
                      3)} "
                      "${parameter.units}",
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),
                const Text(
                  "Last value: ",
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "${parameter.lastValue.toStringAsFixed(
                      3)} "
                      "${parameter.units}",
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),
                const Text(
                  "Last time updated: ",
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  transformDateFormat(
                      parameter.lastUpdated
                  ),
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),
              ],
            )
        )
    );
  }
}
