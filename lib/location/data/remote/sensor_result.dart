import 'package:deepbreath/location/data/remote/parameter_response.dart';

class SensorResponse {
  String name;
  ParameterResponse parameter;

  SensorResponse({
    required this.name,
    required this.parameter,
  });

  factory SensorResponse.fromJson(Map<String, dynamic> json) {
    return SensorResponse(
      name: json['name'],
      parameter: ParameterResponse.fromJson(json['parameter']),
    );
  }
}
