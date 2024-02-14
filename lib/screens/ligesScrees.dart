// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'standingScreen.dart';
import '../models/comptionsCountry.dart';
import '../services/countriesComptionApi.dart';

class LigesScreen extends StatefulWidget {
  final String countryName;
  final String countryId;
  const LigesScreen({required this.countryName, required this.countryId});

  @override
  State<LigesScreen> createState() => _LigesScreenState();
}

class _LigesScreenState extends State<LigesScreen> {
  List<ComptionCountry> comptions = <ComptionCountry>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.countryName),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: comptions.length,
          itemBuilder: (context, index) {
            final comp = comptions[index];
            final country_id = comp.country_id;
            final country_name = comp.country_name;
            final league_id = comp.league_id;
            final league_name = comp.league_name;
            final league_season = comp.league_season;
            final league_logo = comp.league_name;
            final country_logo = comp.league_logo;
            return ListTile(
                leading: CircleAvatar(
                    backgroundImage: country_logo.isNotEmpty
                        ? NetworkImage(country_logo) as ImageProvider<Object>?
                        : AssetImage('assets/placeholder_image.png'),
                    backgroundColor: Colors.white,
                  ),
                title: RichText(
                  text: TextSpan(
                      text: league_name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: ' ' + league_season,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ))
                      ]),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StandingScreen(
                          league_name: comp.league_name,
                          league_id: comp.league_id,
                          league_season: comp.league_season),
                    ),
                  );
                });
          },
        ));
  }

  Future<void> getComptions() async {
    final Response =
        await CountriesComptionApi.getCountryComtion(widget.countryId);
    setState(() {
      comptions = Response;
      print(comptions);
    });
  }
}
