import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/parameter.dart';

class Location {
  int id;
  String name;
  String timezone;
  String owner;
  String provider;
  List<String> instruments;
  List<Parameter> sensors;
  String datetimeLast;

  Location({
    required this.id,
    required this.name,
    required this.timezone,
    required this.owner,
    required this.provider,
    required this.instruments,
    required this.sensors,
    required this.datetimeLast,
  });

  factory Location.fromLocationResponse(LocationResponse response) {
    return Location(
        id: response.id,
        name: response.name,
        timezone: response.timezone,
        owner: response.owner.name,
        provider: response.provider.name,
        instruments: List<String>.from(
          response.instruments.map((x) => x.name)
        ),
        sensors: List<Parameter>.from(
          response.sensors.map((x) =>
              Parameter.fromParameterResponse(x.parameter)
          )
        ),
        datetimeLast: response.datetimeLast.local
    );
  }
}
