class PlayerModel {
  final int id;
  final String username;
  final int hackingPower;
  final int money;

  PlayerModel({
    required this.id,
    required this.username,
    required this.hackingPower,
    required this.money,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      username: json['username'],
      hackingPower: json['hacking_power'],
      money: json['money'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "hacking_power": hackingPower,
      "money": money,
    };
  }
}
