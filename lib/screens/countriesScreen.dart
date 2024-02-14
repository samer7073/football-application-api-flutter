import 'package:flutter/material.dart';
import 'package:flutter_application_football_samer/models/countries.dart';
import 'package:http/http.dart';
import 'ligesScrees.dart';
import '../services/countriesApi.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<Countries> countries = <Countries>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/live');
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.live_tv),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Countries'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          final country_id = country.country_id;
          final country_name = country.country_name;
          final country_logo = country.country_logo;
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(country_logo)),
            title: Text(country_name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LigesScreen(
                      countryName: country.country_name, countryId: country_id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getCountries() async {
    final Response = await CountriesApi.getCountries();
    setState(() {
      countries = Response;
      print(countries);
    });
  }
}
