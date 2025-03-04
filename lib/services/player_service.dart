import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player_model.dart';

class PlayerService {
  static const String baseUrl = "http://127.0.0.1:5000"; // 🔥 Mets l'adresse correcte si besoin

  // 🔹 Récupérer un joueur par ID
  static Future<PlayerModel> getPlayer(int playerId) async {
    final response = await http.get(Uri.parse("$baseUrl/players/$playerId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PlayerModel.fromJson(data);
    } else {
      throw Exception("Erreur lors de la récupération du joueur");
    }
  }

  // 🔹 Incrémenter l'expérience du joueur (XP)
  static Future<void> incrementPlayerXP(int playerId) async {
    final response = await http.post(Uri.parse("$baseUrl/players/$playerId/click"));

    if (response.statusCode != 200) {
      throw Exception("Erreur lors de l'incrémentation de l'XP");
    }
  }

  // 🔹 Acheter une amélioration
  static Future<void> buyEnhancement(int playerId, int enhancementId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/players/$playerId/buy"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"enhancement_id": enhancementId}),
    );

    if (response.statusCode != 200) {
      throw Exception("Erreur lors de l'achat de l'amélioration");
    }
  }
}
