import 'package:deepbreath/location/data/remote/parameter_response.dart';

class Parameter {
  int id;
  String name;
  String units;
  String displayName;
  double average;
  double lastValue;

  Parameter({
    required this.id,
    required this.name,
    required this.units,
    required this.displayName,
    required this.average,
    required this.lastValue,
  });

  factory Parameter.fromParameterResponse(ParameterResponse response) {
    return Parameter(
      id: response.id,
      name: response.name,
      units: response.unit,
      displayName: response.displayName,
      average: response.average,
      lastValue: response.lastValue,
    );
  }
}