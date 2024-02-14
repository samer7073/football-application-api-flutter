import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Standing.dart';

class StandingApi {
  static Future<List<Standing>> getStanding(String league_id) async {
    print("Standing activated");
    String url =
        'https://apiv3.apifootball.com/?action=get_standings&league_id=$league_id&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jason = jsonDecode(body);
    final results = jason as List<dynamic>;

    final standings = results.map<Standing>((e) {
      return Standing(
          league_name: e['league_name'],
          team_name: e['team_name'],
          overall_league_payed: e['overall_league_payed'],
          overall_league_GF: e['overall_league_GF'],
          overall_league_GA: e['overall_league_GA'],
          overall_league_PTS: e['overall_league_PTS'],
          team_badge: e['team_badge'],
          team_id: e['team_id']);
    }).toList();

    return standings;
  }
}
