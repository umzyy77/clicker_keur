class DifficultyModel {
  final int id;
  final String label;
  final int clicksRequired;

  DifficultyModel({
    required this.id,
    required this.label,
    required this.clicksRequired,
  });

  factory DifficultyModel.fromJson(Map<String, dynamic> json) {
    return DifficultyModel(
      id: json['id'],
      label: json['label'],
      clicksRequired: json['clicks_required'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "label": label,
      "clicks_required": clicksRequired,
    };
  }
}
