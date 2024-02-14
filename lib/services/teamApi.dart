import 'dart:convert';

import 'package:flutter_application_football_samer/models/coaches.dart';
import 'package:flutter_application_football_samer/models/players.dart';
import 'package:flutter_application_football_samer/models/team.dart';
import 'package:flutter_application_football_samer/models/venue.dart';

import 'package:http/http.dart' as http;

class TeamApi {
  static Future<List<Team>> getTeams(String league_id) async {
    print("Teams activited");
    String url =
        "https://apiv3.apifootball.com/?action=get_teams&league_id=$league_id&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jason = jsonDecode(body);
    final results = jason as List<dynamic>;
    final teams = results.map<Team>(
      (e) {
        final players = Players(
            player_id: e['players']['player_id'],
            player_image: e['players']['player_image'],
            player_name: e['players']['player_name'],
            player_type: e['players']['player_type'],
            player_age: e['players']['player_age']);
        final venue = Venue(
            venue_name: e['venue']['venue_name'],
            venue_address: e['venue']['venue_address'],
            venue_city: e['venue']['venue_city'],
            venue_capacity: e['venue']['venue_capacity'],
            venue_surface: e['venue']['venue_surface']);
        final coaches = Coaches(coach_name: e['coaches']['coach_name']);
        return Team(
            team_name: e['team_name'],
            team_country: e['team_country'],
            team_founded: e['team_founded'],
            team_badge: e['team_badge'],
            venue: venue,
            players: players,
            coaches: coaches);
      },
    ).toList();
    return teams;
  }
}
