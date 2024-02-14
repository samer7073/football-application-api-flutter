// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_football_samer/models/TopScore.dart';
import 'package:flutter_application_football_samer/screens/HomeScreen.dart';
import 'package:flutter_application_football_samer/screens/countriesScreen.dart';
import 'package:flutter_application_football_samer/screens/livematches.dart';
import 'package:flutter_application_football_samer/screens/standingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => CountriesScreen(),
        '/live': (context) => livematch(),
      },
    );
  }
}
