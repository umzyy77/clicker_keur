import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:5000"; // Change selon ton backend

  // Méthode GET
  static Future<dynamic> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse("$baseUrl$endpoint"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur de connexion à l'API : ${response.statusCode}");
    }
  }

  // Méthode POST
  static Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur de connexion à l'API : ${response.statusCode}");
    }
  }

  // Méthode DELETE
  static Future<void> deleteRequest(String endpoint) async {
    final response = await http.delete(Uri.parse("$baseUrl$endpoint"));
    if (response.statusCode != 200) {
      throw Exception("Erreur lors de la suppression : ${response.statusCode}");
    }
  }
}
