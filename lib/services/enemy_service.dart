import '../models/enemy_model.dart';
import 'api_service.dart';

class EnemyService {
  // Récupérer tous les ennemis depuis Flask
  static Future<List<EnemyModel>> getAllEnemies() async {
    final data = await ApiService.getRequest("/enemies");
    return data.map<EnemyModel>((json) => EnemyModel.fromJson(json)).toList();
  }

  // Récupérer un ennemi spécifique par niveau
  static Future<EnemyModel> getEnemyByLevel(int level) async {
    final data = await ApiService.getRequest("/enemies/$level");
    return EnemyModel.fromJson(data);
  }
}
