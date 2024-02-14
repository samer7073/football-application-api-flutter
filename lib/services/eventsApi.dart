import 'dart:convert';

import '../models/Events.dart';
import 'package:http/http.dart' as http;

class EventsApi {
  static Future<List<Events>> getEvents() async {
    print("Events Activied");
    String url =
        "https://apiv3.apifootball.com/?action=get_events&from=2024-02-08&to=2024-02-08&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jason = jsonDecode(body);
    final results = jason as List<dynamic>;
    final event = results.map<Events>((e) {
      return Events(
          match_id: e['match_id'],
          country_id: e['country_id'],
          country_name: e['country_name'],
          league_id: e['league_id'],
          league_name: e['league_name'],
          match_date: e['match_date'],
          match_status: e['match_status'],
          match_time: e['match_time'],
          match_hometeam_id: e['match_hometeam_id'],
          match_hometeam_name: e['match_hometeam_name'],
          match_hometeam_ft_score: e['match_hometeam_ft_score'],
          match_awayteam_ft_score: e['match_awayteam_ft_score'],
          match_stadium: e['match_stadium'],
          match_referee: e['match_referee'],
          team_home_badge: e['team_home_badge'],
          team_away_badge: e['team_away_badge'],
          league_logo: e['league_logo'],
          country_logo: e['country_logo'],
          league_year: e['league_year']);
    }).toList();
    return event;
  }
}
