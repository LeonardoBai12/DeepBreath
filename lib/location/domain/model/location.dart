import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/domain/model/parameter.dart';

class Location {
  int id;
  String name;
  String? city;
  String? owner;
  String? provider;
  String? instrument;
  String? timezone;
  bool isMobile;
  bool isMonitor;
  List<Parameter> parameters;
  String lastUpdated;
  String firstUpdated;
  double? latitude;
  double? longitude;

  Location({
    required this.id,
    required this.name,
    required this.city,
    required this.owner,
    required this.provider,
    required this.instrument,
    required this.timezone,
    required this.isMobile,
    required this.isMonitor,
    required this.parameters,
    required this.lastUpdated,
    required this.firstUpdated,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromLocationResponse(LocationResponse r) {
    return Location(
      id: r.id,
      name: r.name ?? '',
      city: r.city,
      owner: r.owner,
      provider: r.provider,
      instrument: r.instrument,
      timezone: r.timezone,
      isMobile: r.isMobile,
      isMonitor: r.isMonitor,
      parameters: r.parameters
          .map((x) => Parameter.fromParameterResponse(x))
          .toList(),
      lastUpdated: r.lastUpdated,
      firstUpdated: r.firstUpdated,
      latitude: r.latitude,
      longitude: r.longitude,
    );
  }
}
