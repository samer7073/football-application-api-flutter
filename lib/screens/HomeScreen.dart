// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_football_samer/models/Player.dart';
import 'package:flutter_application_football_samer/models/TopScore.dart';
import 'package:flutter_application_football_samer/services/topScore_api.dart';
import 'package:flutter_application_football_samer/services/topScore_api.dart';

class HomeScreen extends StatefulWidget {
  String league_id;
  String league_name;
  String league_season;
  HomeScreen(
      {required this.league_id,
      required this.league_name,
      required this.league_season});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TopScore> topscore = [];
  List<Player> player = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: RichText(
          text: TextSpan(
              text: widget.league_name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                    text: " " + widget.league_season,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ))
              ]),
        ),
        centerTitle: true,
      ),
      body: topscore.isEmpty
          ? Center(
              child: Text(
                'Aucune information disponible pour cette ligue',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: topscore.length,
              itemBuilder: (context, index) {
                final top = topscore[index];
                final name = top.player_name;

                final team = top.team_name;
                final goals = top.goals;
                final penalty_goals = top.penalty_goals;

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(name),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Team : " + team),
                        Text("goals : " + goals),
                        Text("Penalty : " + penalty_goals)
                      ]),
                );
              },
            ),
    );
  }

  Future<void> getTopScores() async {
    final reponse = await TopScoreApi.getTopScores(widget.league_id);
    setState(() {
      topscore = reponse;
    });
  }
}
