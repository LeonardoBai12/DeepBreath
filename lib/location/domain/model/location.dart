import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/parameter.dart';

class Location {
  int id;
  String name;
  String? city;
  String sensorManufacturer;
  String sensorModel;
  List<Parameter> parameters;
  String lastUpdated;

  Location({
    required this.id,
    required this.name,
    required this.city,
    required this.sensorManufacturer,
    required this.sensorModel,
    required this.parameters,
    required this.lastUpdated,
  });

  factory Location.fromLocationResponse(LocationResponse response) {
    return Location(
        id: response.id,
        name: response.name ?? "",
        city: response.city,
        sensorManufacturer: response.manufacturers.first.manufacturerName,
        sensorModel: response.manufacturers.first.modelName,
        parameters: List<Parameter>.from(
          response.parameters.map((x) =>
            Parameter.fromParameterResponse(x)
          )
        ),
        lastUpdated: response.lastUpdated
    );
  }
}
