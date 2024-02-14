import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/TopScore.dart';

class TopScoreApi {
  static Future<List<TopScore>> getTopScores(String leagueId) async {
    print("TopScore activé");
    String url =
        'https://apiv3.apifootball.com/?action=get_topscorers&league_id=$leagueId&APIkey=a26470fd99b08302981994c9890be81b94c43ace09c9022dc09ece9370079007';
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final results = json as List<dynamic>;
        final topScores = results.map(
          (e) {
            return TopScore(
                player_name: e['player_name'],
                team_name: e['team_name'],
                goals: e['goals'],
                penalty_goals: e['penalty_goals']);
          },
        ).toList();
        return topScores;
      } else {
        // En cas d'erreur de l'API, vous pouvez retourner une liste vide ou lancer une exception
        // Dans cet exemple, nous retournons simplement une liste vide
        print("Erreur: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      // En cas d'erreur lors de la requête HTTP, vous pouvez également renvoyer une liste vide ou un message d'erreur
      // Dans cet exemple, nous imprimons simplement l'erreur
      print("Erreur lors de la requête HTTP: $e");
      return [];
    }
  }
}
