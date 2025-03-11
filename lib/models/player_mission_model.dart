class PlayerMissionModel {
  final int mission;
  int status;
  int clicksDone;

  PlayerMissionModel({
    required this.mission,
    required this.status,
    required this.clicksDone,
  });

  factory PlayerMissionModel.fromJson(Map<String, dynamic> json) {
    return PlayerMissionModel(
      mission: json['id_mission'],
      status: json['id_status'],
      clicksDone: json['clicks_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mission": mission,
      "status": status,
      "clicks_done": clicksDone,
    };
  }
}
