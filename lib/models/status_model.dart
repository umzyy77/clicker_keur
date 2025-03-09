class StatusModel {
  final int idStatus;
  final String label;

  StatusModel({
    required this.idStatus,
    required this.label,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      idStatus: json['id_status'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_status": idStatus,
      "label": label,
    };
  }
}
