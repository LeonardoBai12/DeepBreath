import 'package:deepbreath/location/data/remote/parameter_response.dart';

class Parameter {
  int sensorId;
  int id;
  String name;
  String units;
  String displayName;

  Parameter({
    required this.sensorId,
    required this.id,
    required this.name,
    required this.units,
    required this.displayName,
  });

  factory Parameter.fromParameterResponse(ParameterResponse response) {
    return Parameter(
      sensorId: response.sensorId,
      id: response.id,
      name: response.name,
      units: response.unit,
      displayName: response.displayName,
    );
  }
}
