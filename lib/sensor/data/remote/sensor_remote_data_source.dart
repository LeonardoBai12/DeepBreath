import 'dart:convert';
import 'package:deepbreath/sensor/data/remote/sensor_measurement_response.dart';
import 'package:deepbreath/utils/api_secrets.dart';
import 'package:deepbreath/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SensorRemoteDataSource {
  Future<List<SensorMeasurementResponse>> getLatestMeasurements(int locationId) async {
    final url = '${Constants.baseUrlV3}locations/$locationId/latest';
    debugPrint('SensorRemoteDataSource: fetching $url');
    final response = await http.get(Uri.parse(url), headers: {'X-API-Key': ApiSecrets.openAqApiKey});
    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData['results'] != null) {
        return List<SensorMeasurementResponse>.from(
          jsonData['results'].map((r) => SensorMeasurementResponse.fromJson(r as Map<String, dynamic>)),
        );
      }
      throw Exception('Invalid JSON format or missing "results" key');
    }
    throw Exception('Failed to load latest measurements: ${response.statusCode} — ${utf8.decode(response.bodyBytes)}');
  }
}
