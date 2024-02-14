import 'package:flutter_application_football_samer/models/coaches.dart';
import 'package:flutter_application_football_samer/models/players.dart';
import 'package:flutter_application_football_samer/models/venue.dart';

class Team {
  final String team_name;
  final String team_country;
  final String team_founded;
  final String team_badge;
  final Venue venue;
  final List<Players> players; // Modifier le type en List<Players>
  final List<Coaches> coaches; // Modifier le type en List<Coaches>

  Team({
    required this.team_name,
    required this.team_country,
    required this.team_founded,
    required this.team_badge,
    required this.venue,
    required this.players,
    required this.coaches,
  });
}
