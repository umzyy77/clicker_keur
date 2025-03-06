class StatusModel {
  final int id;
  final String label;

  StatusModel({required this.id, required this.label});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "label": label,
    };
  }
}
