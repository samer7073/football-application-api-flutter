import '../models/matchLive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveMatchApi {
  static Future<List<LiveMatch>> getMatches() async {
    print("Matches Live activer");
    const url =
        'https://apiv3.apifootball.com/?action=get_events&match_live=1&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final Body = response.body;
    final jason = jsonDecode(Body);
    final resultat = jason as List<dynamic>;
    final matches = resultat.map(
      (e) {
        return LiveMatch(
          league_name: e['league_name'],
          country_name: e['country_name'],
          match_status: e['match_status'],
          match_hometeam_name: e['match_hometeam_name'],
          match_awayteam_name: e['match_awayteam_name'],
          match_hometeam_score: e['match_hometeam_score'],
          match_awayteam_score: e['match_awayteam_score'],
          match_stadium: e['match_stadium'],
          team_home_badge: e['team_home_badge'],
          team_away_badge: e['team_away_badge'],
          league_logo: e['league_logo'],
          country_logo: e['country_logo'],
        );
      },
    ).toList();
    return matches;
    print("finched fetch matches ");
  }
}
