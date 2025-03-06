import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:5000';

  /// 🔹 Effectue une requête GET
  Future<dynamic> getRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl$endpoint'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ GET $endpoint - Erreur: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🚨 Exception GET $endpoint: $e");
      return null;
    }
  }

  /// 🔹 Effectue une requête POST
  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl$endpoint'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ POST $endpoint - Erreur: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 Exception POST $endpoint: $e");
      return null;
    }
  }

  /// 🔹 Effectue une requête PATCH
  Future<bool> patchRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.patch(
        Uri.parse('$apiUrl$endpoint'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("❌ PATCH $endpoint - Erreur: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🚨 Exception PATCH $endpoint: $e");
      return false;
    }
  }

  /// 🔹 Effectue une requête DELETE
  Future<bool> deleteRequest(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl$endpoint'));

      if (response.statusCode == 200) {
        return true;
      } else {
        print("❌ DELETE $endpoint - Erreur: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🚨 Exception DELETE $endpoint: $e");
      return false;
    }
  }
}
