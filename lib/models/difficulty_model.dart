class DifficultyModel {
  final int idDifficulty;
  final String label;
  final int clicksRequired;

  DifficultyModel({
    required this.idDifficulty,
    required this.label,
    required this.clicksRequired,
  });

  factory DifficultyModel.fromJson(Map<String, dynamic> json) {
    return DifficultyModel(
      idDifficulty: json['id_difficulty'],
      label: json['label'],
      clicksRequired: json['clicks_required'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_difficulty": idDifficulty,
      "label": label,
      "clicks_required": clicksRequired,
    };
  }
}