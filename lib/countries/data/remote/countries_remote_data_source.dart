import 'package:deepbreath/countries/utils/countries_constants.dart';

import 'country_result.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountriesRemoteDataSource {
  Future<List<CountryResult>> getCountries() async {
    final response = await http.get(Uri.parse(
        CountriesConstants.baseUrl + CountriesConstants.countriesEndpoint
    ));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => CountryResult.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<CountryResult?> getCountryDetails(String code) async {
    return null;
  }
}
