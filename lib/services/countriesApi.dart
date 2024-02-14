import 'dart:convert';

import 'package:flutter_application_football_samer/models/countries.dart';
import 'package:http/http.dart' as http;

class CountriesApi {
  static Future<List<Countries>> getCountries() async {
    print("countries activited");
    const url =
        "https://apiv3.apifootball.com/?action=get_countries&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final Body = response.body;
    final jason = jsonDecode(Body);
    final resultat = jason as List<dynamic>;
    final countries = resultat.map((e) {
      return Countries(
          country_id: e['country_id'],
          country_name: e['country_name'],
          country_logo: e['country_logo']);
    }).toList();
    return countries;
  }
}
