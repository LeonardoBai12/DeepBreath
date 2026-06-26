import 'package:deepbreath/location/data/remote/parameter_response.dart';

class LocationResponse {
  int id;
  String? name;
  String? city;
  String? owner;
  String? provider;
  String? instrument;
  String? timezone;
  bool isMobile;
  bool isMonitor;
  List<ParameterResponse> parameters;
  String lastUpdated;
  String firstUpdated;
  double? latitude;
  double? longitude;

  LocationResponse({
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

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    final sensors = json['sensors'] as List<dynamic>? ?? [];
    final instruments = json['instruments'] as List<dynamic>? ?? [];
    final coords = json['coordinates'] as Map<String, dynamic>?;

    String dateUtc(dynamic field) {
      if (field is Map) return field['utc'] as String? ?? '';
      return field as String? ?? '';
    }

    return LocationResponse(
      id: json['id'] as int,
      name: json['name'] as String?,
      city: json['locality'] as String?,
      owner: (json['owner'] as Map<String, dynamic>?)?['name'] as String?,
      provider: (json['provider'] as Map<String, dynamic>?)?['name'] as String?,
      instrument: instruments.isNotEmpty
          ? (instruments.first as Map<String, dynamic>)['name'] as String?
          : null,
      timezone: json['timezone'] as String?,
      isMobile: json['isMobile'] as bool? ?? false,
      isMonitor: json['isMonitor'] as bool? ?? false,
      parameters: sensors
          .map((s) => ParameterResponse.fromJson(s as Map<String, dynamic>))
          .toList(),
      lastUpdated: dateUtc(json['datetimeLast']),
      firstUpdated: dateUtc(json['datetimeFirst']),
      latitude: (coords?['latitude'] as num?)?.toDouble(),
      longitude: (coords?['longitude'] as num?)?.toDouble(),
    );
  }
}
