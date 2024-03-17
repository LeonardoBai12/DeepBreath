import 'package:deepbreath/location/data/remote/manufacturer_result.dart';
import 'package:deepbreath/location/data/remote/parameter_response.dart';

class LocationResponse {
  int id;
  String? name;
  String? city;
  List<ParameterResponse> parameters;
  List<ManufacturerResponse> manufacturers;
  String lastUpdated;

  LocationResponse({
    required this.id,
    required this.name,
    required this.city,
    required this.parameters,
    required this.manufacturers,
    required this.lastUpdated,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      parameters: List<ParameterResponse>.from(
          json['parameters'].map((x) => ParameterResponse.fromJson(x))
      ),
      manufacturers:  List<ManufacturerResponse>.from(
          json['manufacturers'].map((x) => ManufacturerResponse.fromJson(x))
      ),
      lastUpdated: json['lastUpdated']
    );
  }
}
