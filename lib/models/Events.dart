class Events {
  final String match_id;
  final String country_id;
  final String country_name;
  final String league_id;
  final String league_name;
  final String match_date;
  final String match_status;
  final String match_time;
  final String match_hometeam_id;
  final String match_hometeam_name;
  final String match_hometeam_ft_score;
  final String match_awayteam_ft_score;
  final String match_stadium;
  final String match_referee;
  final String team_home_badge;
  final String team_away_badge;
  final String league_logo;
  final String country_logo;
  final String league_year;

  Events({
    required this.match_id,
    required this.country_id,
    required this.country_name,
    required this.league_id,
    required this.league_name,
    required this.match_date,
    required this.match_status,
    required this.match_time,
    required this.match_hometeam_id,
    required this.match_hometeam_name,
    required this.match_hometeam_ft_score,
    required this.match_awayteam_ft_score,
    required this.match_stadium,
    required this.match_referee,
    required this.team_home_badge,
    required this.team_away_badge,
    required this.league_logo,
    required this.country_logo,
    required this.league_year,
  });
}
