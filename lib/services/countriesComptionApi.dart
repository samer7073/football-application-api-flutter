import 'dart:convert';

import '../models/comptionsCountry.dart';
import 'package:http/http.dart' as http;

class CountriesComptionApi {
  static Future<List<ComptionCountry>> getCountryComtion(
      String countryId) async {
    print("Comption Activated");
    final url =
        "https://apiv3.apifootball.com/?action=get_leagues&country_id=$countryId&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final resultat = json as List<dynamic>;
    final comtions = resultat.map((e) {
      return ComptionCountry(
          country_id: e['country_id'],
          country_name: e['country_name'],
          league_id: e['league_id'],
          league_name: e['league_name'],
          league_season: e['league_season'],
          league_logo: e['league_logo'],
          country_logo: e['country_logo']);
    }).toList();
    return comtions;
  }
}
