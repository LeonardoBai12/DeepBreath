import 'dart:convert';

import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/util/location_constants.dart';
import 'package:deepbreath/utils/constants.dart';
import 'package:http/http.dart' as http;

class LocationRemoteDataSource {
  final String baseUrl = 'https://api.openaq.org/v3/locations';

  Future<List<LocationResponse>> getLocationsByCountryId(int countryId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Constants.baseUrl}${LocationConstants.locationEndpoint}?countries_id=$countryId'
      ));


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['results'] != null) {
          List<LocationResponse> locations = List<LocationResponse>.from(
            jsonData['results'].map((result) => LocationResponse.fromJson(result)),
          );
          return locations;
        } else {
          throw Exception('Invalid JSON format or missing "results" key');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
