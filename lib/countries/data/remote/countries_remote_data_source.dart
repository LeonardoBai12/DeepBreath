import 'package:deepbreath/countries/utils/countries_constants.dart';

import '../../../utils/api_secrets.dart';
import '../../../utils/constants.dart';
import 'country_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountriesRemoteDataSource {
  Future<List<CountryResponse>> getCountries() async {
    final response = await http.get(
      Uri.parse(Constants.baseUrlV3 + CountriesConstants.countriesEndpoint),
      headers: {'X-API-Key': ApiSecrets.openAqApiKey},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));

      if (jsonData['results'] != null) {
        List<CountryResponse> countries = List<CountryResponse>.from(
          jsonData['results'].map((result) =>
              CountryResponse.fromJson(result)),
        );
        countries.sort((a, b) => a.name.compareTo(b.name));
        return countries;
      } else {
        throw Exception('Invalid JSON format or missing "results" key');
      }
    } else {
      throw Exception('Failed to load countries: ${response.statusCode} — ${utf8.decode(response.bodyBytes)}');
    }
  }
}
