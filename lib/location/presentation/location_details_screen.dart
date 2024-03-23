import 'package:deepbreath/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/blur_effect.dart';
import '../../utils/theme.dart';
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
          backgroundColor: DeepBreathColors.appBarBackground,
          flexibleSpace: const BlurEffect(),
        ),
        body: Stack(
            children: [
              SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocationData(location: _location, size: size),
                        Padding(
                          padding: DeepBreathPaddings.smallHorizontalPadding,
                          child: ParametersGridView(
                              itemWidth: itemWidth,
                              itemHeight: itemHeight,
                              location: _location
                          ),
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
      style: DeepBreathTextStyles.title
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
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
        ),
        itemCount: _location.parameters.length,
        itemBuilder: (context, index) {
          Parameter parameter = _location.parameters[index];
          return ParameterItem(parameter: parameter);
        }
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
        padding: DeepBreathPaddings.dataPadding,
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
                      style: DeepBreathTextStyles.mediumHeader,
                    ),
                    Text(
                      _location.city ?? "",
                      style: DeepBreathTextStyles.bigCaption,
                    )
                  ]
              ) : SizedBox(width: size.width),
              const Text(
                "Sensor manufacturer: ",
                style: DeepBreathTextStyles.mediumHeader,
              ),
              Text(
                _location.sensorManufacturer,
                style: DeepBreathTextStyles.bigCaption,
              ),
              const Text(
                "Sensor model: ",
                style: DeepBreathTextStyles.mediumHeader,
              ),
              Text(
                _location.sensorModel,
                style: DeepBreathTextStyles.bigCaption,
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
        surfaceTintColor: DeepBreathColors.cardBackground,
        shape: DeepBreathTextShapes.cardBorder,
        child: Padding(
            padding: DeepBreathPaddings.mainAllPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parameter.displayName,
                  style: DeepBreathTextStyles.subtitle,
                ),
                const Text(
                  "Average: ",
                  style: DeepBreathTextStyles.smallHeader,
                ),
                Text(
                  "${parameter.average.toStringAsFixed(
                      3)} "
                      "${parameter.units}",
                  style: DeepBreathTextStyles.mediumCaption,
                ),
                const Text(
                  "Last value: ",
                  style: DeepBreathTextStyles.smallHeader,
                ),
                Text(
                  "${parameter.lastValue.toStringAsFixed(
                      3)} "
                      "${parameter.units}",
                  style: DeepBreathTextStyles.mediumCaption,
                ),
                const Text(
                  "Last time updated: ",
                  style: DeepBreathTextStyles.smallHeader,
                ),
                Text(
                  transformDateFormat(
                      parameter.lastUpdated
                  ),
                  style: DeepBreathTextStyles.mediumCaption,
                ),
              ],
            )
        )
    );
  }
}
