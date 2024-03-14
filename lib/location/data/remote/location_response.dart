import 'package:deepbreath/location/data/remote/named_response.dart';
import 'package:deepbreath/location/data/remote/sensor_result.dart';

import 'date_time_response.dart';

class LocationResponse {
  int id;
  String name;
  String timezone;
  NamedResponse owner;
  NamedResponse provider;
  List<NamedResponse> instruments;
  List<SensorResponse> sensors;
  DateTimeResponse datetimeLast;

  LocationResponse({
    required this.id,
    required this.name,
    required this.timezone,
    required this.owner,
    required this.provider,
    required this.instruments,
    required this.sensors,
    required this.datetimeLast,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      id: json['id'],
      name: json['name'],
      timezone: json['timezone'],
      owner: NamedResponse.fromJson(json['owner']),
      provider: NamedResponse.fromJson(json['provider']),
      instruments: List<NamedResponse>.from(
          json['instruments'].map((x) => NamedResponse.fromJson(x))
      ),
      sensors:  List<SensorResponse>.from(
          json['sensors'].map((x) => SensorResponse.fromJson(x))
      ),
      datetimeLast: json['datetimeLast'],
    );
  }
}
