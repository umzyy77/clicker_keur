class PlayerModel {
  final int idPlayer;
  final String username;
  final int hackingPower;
  final int money;

  PlayerModel({
    required this.idPlayer,
    required this.username,
    required this.hackingPower,
    required this.money,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      idPlayer: json['id_player'],
      username: json['username'],
      hackingPower: json['hacking_power'],
      money: json['money'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_player": idPlayer,
      "username": username,
      "hacking_power": hackingPower,
      "money": money,
    };
  }

  int get id => idPlayer;
}