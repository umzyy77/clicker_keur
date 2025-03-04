class PlayerModel {
  final int id;
  String pseudo;
  int totalExperience;
  int clickDamage;
  int currentEnemyLevel;

  PlayerModel({
    required this.id,
    required this.pseudo,
    required this.totalExperience,
    required this.clickDamage,
    required this.currentEnemyLevel,
  });

  // 🔹 Convertir JSON en PlayerModel
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id_player'] ?? 0,
      pseudo: json['pseudo'] ?? "Inconnu",
      totalExperience: json['total_experience'] ?? 0,
      clickDamage: json['click_damage'] ?? 1,
      currentEnemyLevel: json['id_enemy'] ?? 1,
    );
  }
}
