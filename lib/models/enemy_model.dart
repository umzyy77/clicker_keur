class EnemyModel {
  final String name;
  final int totalLife;
  int currentLife;
  final int level;

  EnemyModel({
    required this.name,
    required this.totalLife,
    required this.level,
  }) : currentLife = totalLife;

  // Factory pour convertir JSON -> Objet EnemyModel
  factory EnemyModel.fromJson(Map<String, dynamic> json) {
    return EnemyModel(
      name: json['name'],
      totalLife: json['total_life'],
      level: json['level'],
    )..currentLife = json['current_life']; // Assigner la vie actuelle
  }

  // Réduit la vie de l’ennemi quand il est attaqué
  void reduceLife(int damage) {
    currentLife = (currentLife - damage).clamp(0, totalLife);
  }
}
