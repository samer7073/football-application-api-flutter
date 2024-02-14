import 'package:flutter/material.dart';
import 'package:flutter_application_football_samer/models/Standing.dart';
import 'package:flutter_application_football_samer/services/Standing_api.dart';

import 'HomeScreen.dart';
import 'teamScreen.dart';

class StandingScreen extends StatefulWidget {
  final String league_name;
  final String league_id;
  final String league_season;
  const StandingScreen({
    required this.league_name,
    required this.league_id,
    required this.league_season,
  });

  @override
  State<StandingScreen> createState() => _StandingScreenState();
}

class _StandingScreenState extends State<StandingScreen> {
  List<Standing> StandingList = [];

  @override
  void initState() {
    super.initState();
    getStanding();
  }

  @override
  Widget build(BuildContext context) {
    String firstLeagueName = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: RichText(
          text: TextSpan(
            text: widget.league_name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: widget.league_season,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    league_id: widget.league_id,
                    league_name: widget.league_name,
                    league_season: widget.league_season,
                  ),
                ),
              );
            },
            child: Text("Top Scores"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: StandingList.length,
              itemBuilder: (context, index) {
                final stand = StandingList[index];
                final team_id = stand.team_id;
                final team_name = stand.team_name;
                final overall_league_payed = stand.overall_league_payed;
                final overall_league_GF = stand.overall_league_GF;
                final overall_league_GA = stand.overall_league_GA;
                final overall_league_PTS = stand.overall_league_PTS;
                final team_badge = stand.team_badge;
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamScreen(
                          team_id: team_id,
                          team_badge: team_badge, // Correction ici
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: team_badge.isNotEmpty
                        ? NetworkImage(team_badge) as ImageProvider<Object>?
                        : AssetImage('assets/placeholder_image.png'),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    "${index + 1}. " + team_name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Points : " + overall_league_PTS),
                      Text("Played Matchs : " + overall_league_payed),
                      Text("Goals For : $overall_league_GF"),
                      Text("Goals Against : $overall_league_GA"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getStanding() async {
    final response = await StandingApi.getStanding(widget.league_id);
    setState(() {
      StandingList = response;
    });
  }
}
