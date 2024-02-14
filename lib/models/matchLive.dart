class LiveMatch {
  final String country_name;
  final String league_name;
  final String match_status;
  final String match_hometeam_name;
  final String match_awayteam_name;
  final String match_hometeam_score;
  final String match_awayteam_score;
  final String match_stadium;
  final String team_home_badge;
  final String team_away_badge;
  final String league_logo;
  final String country_logo;

  LiveMatch(
      {required this.country_name,
      required this.league_name,
      required this.match_status,
      required this.match_hometeam_name,
      required this.match_awayteam_name,
      required this.match_hometeam_score,
      required this.match_awayteam_score,
      required this.match_stadium,
      required this.team_home_badge,
      required this.team_away_badge,
      required this.league_logo,
      required this.country_logo});
}
