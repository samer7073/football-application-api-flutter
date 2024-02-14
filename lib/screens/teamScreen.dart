import 'package:flutter/material.dart';
import 'package:flutter_application_football_samer/models/team.dart';
import 'package:flutter_application_football_samer/services/teamApi.dart';

class TeamScreen extends StatefulWidget {
  final String team_id;
  final String team_badge;
  const TeamScreen({required this.team_id, required this.team_badge});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
    getTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEAM"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.team_badge),
                // Vous pouvez ajouter d'autres propriétés CircleAvatar ici
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> getTeam() async {
    print(widget.team_id);

    final response = await TeamApi.getTeams(widget.team_id);

    setState(() {
      teams = response;
    });
  }
}
