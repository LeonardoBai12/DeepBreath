import 'dart:convert';

import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/util/location_constants.dart';
import 'package:deepbreath/utils/constants.dart';
import 'package:http/http.dart' as http;

class LocationRemoteDataSource {
  Future<List<LocationResponse>> getLocationsByCountryByCode(String code) async {
    try {
      final response = await http.get(
          Uri.parse(
              "${Constants.baseUrlV2}"
                  "${LocationConstants.locationEndpoint}"
                  "?country=$code"
          )
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));

        if (jsonData['results'] != null) {
          List<LocationResponse> locations = List<LocationResponse>.from(
            jsonData['results'].map((result) =>
                LocationResponse.fromJson(result)
            ),
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
