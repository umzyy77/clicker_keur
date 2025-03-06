class UpgradeModel {
  final int id;
  final String name;

  UpgradeModel({required this.id, required this.name});

  factory UpgradeModel.fromJson(Map<String, dynamic> json) {
    return UpgradeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
