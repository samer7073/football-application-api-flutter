// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_application_football_samer/models/matchLive.dart';
import 'package:flutter_application_football_samer/services/livematch_api.dart';
import 'package:http/http.dart';

class livematch extends StatefulWidget {
  const livematch({super.key});

  @override
  State<livematch> createState() => _livematchState();
}

class _livematchState extends State<livematch> {
  late Future<List<LiveMatch>> matchesFuture;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    matchesFuture = getMatches();
    // Set up a timer to refresh every second
  }

  @override
  Widget build(BuildContext context) {
    matchesFuture = getMatches();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Live Matchs"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            matchesFuture = getMatches();
          });
        },
        child: FutureBuilder<List<LiveMatch>>(
          future: matchesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final matches = snapshot.data;
              return ListView.builder(
                itemCount: matches?.length ?? 0,
                itemBuilder: (context, index) {
                  final match = matches![index];
                  final country_name = match.country_name;
                  final league_name = match.league_name;
                  final match_status = match.match_status;
                  final match_hometeam_name = match.match_hometeam_name;
                  final match_awayteam_name = match.match_awayteam_name;
                  final match_hometeam_score = match.match_hometeam_score;
                  final match_awayteam_score = match.match_awayteam_score;
                  final match_stadium = match.match_stadium;
                  final team_home_badge = match.team_home_badge;
                  final team_away_badge = match.team_away_badge;
                  final league_logo = match.league_logo;
                  final country_logo = match.country_logo;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: country_logo.isNotEmpty
                                  ? NetworkImage(country_logo)
                                      as ImageProvider<Object>?
                                  : AssetImage('assets/placeholder_image.png'),
                              backgroundColor: Colors.white,
                            ),
                            Text(
                              country_name + " : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(league_name)
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 230,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: team_home_badge
                                                .isNotEmpty
                                            ? NetworkImage(team_home_badge)
                                                as ImageProvider<Object>?
                                            : AssetImage(
                                                'assets/placeholder_image.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(match_hometeam_name),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: team_away_badge
                                                .isNotEmpty
                                            ? NetworkImage(team_away_badge)
                                                as ImageProvider<Object>?
                                            : AssetImage(
                                                'assets/placeholder_image.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(match_awayteam_name),
                                    ],
                                  )
                                ]),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            width: 70,
                            child: Center(
                                child: Text(
                              match_status + " '",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      match_hometeam_score,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      match_awayteam_score,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<LiveMatch>> getMatches() async {
    try {
      final Response = await LiveMatchApi.getMatches();
      return Response;
    } catch (error) {
      print("Error fetching matches: $error");
      return []; // Return an empty list in case of an error
    }
  }

  Future<Image> _getImage(String imageUrl) async {
    try {
      // Vérifiez si l'URL est vide ou ne contient pas de nom d'hôte
      if (imageUrl.isEmpty || !imageUrl.contains('http')) {
        throw Exception('Invalid URL: $imageUrl');
      }

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final imageData = response.bodyBytes;
        return Image.memory(imageData);
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load image: $error');
    }
  }
}
