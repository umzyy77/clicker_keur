class UpgradeModel {
  final int idUpgrade;
  final String name;

  UpgradeModel({
    required this.idUpgrade,
    required this.name,
  });

  factory UpgradeModel.fromJson(Map<String, dynamic> json) {
    return UpgradeModel(
      idUpgrade: json['id_upgrade'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_upgrade": idUpgrade,
      "name": name,
    };
  }
}