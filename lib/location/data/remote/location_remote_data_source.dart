import 'dart:convert';

import 'package:deepbreath/location/data/remote/location_response.dart';
import 'package:deepbreath/location/util/location_constants.dart';
import 'package:deepbreath/utils/api_secrets.dart';
import 'package:deepbreath/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LocationRemoteDataSource {
  Future<List<LocationResponse>> getLocationsByCountryId(int countryId) async {
    final url = '${Constants.baseUrlV3}${LocationConstants.locationEndpoint}?countries_id=$countryId&limit=200';
    debugPrint('LocationRemoteDataSource: fetching $url');
    final response = await http.get(
      Uri.parse(url),
      headers: {'X-API-Key': ApiSecrets.openAqApiKey},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));

      if (jsonData['results'] != null) {
        return List<LocationResponse>.from(
          jsonData['results'].map((result) =>
              LocationResponse.fromJson(result)
          ),
        );
      } else {
        throw Exception('Invalid JSON format or missing "results" key');
      }
    } else {
      throw Exception('Failed to load locations: ${response.statusCode} — ${utf8.decode(response.bodyBytes)}');
    }
  }
}
