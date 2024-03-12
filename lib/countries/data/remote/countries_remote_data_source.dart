import 'package:deepbreath/countries/utils/countries_constants.dart';

import '../../../utils/constants.dart';
import 'country_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountriesRemoteDataSource {
  Future<List<CountryResponse>> getCountries() async {
    final response = await http.get(Uri.parse(
        Constants.baseUrl + CountriesConstants.countriesEndpoint
    ));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      final List<CountryResponse> result = data.map((json) => CountryResponse.fromJson(json))
          .toList();
      result.sort((a, b) => a.name.compareTo(b.name));
      return result;
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<CountryResponse?> getCountryDetails(String code) async {
    return null;
  }
}
