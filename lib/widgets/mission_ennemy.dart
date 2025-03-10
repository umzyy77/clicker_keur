import 'package:flutter/material.dart';

class MissionEnnemy extends StatelessWidget {
  final int missionId;

  const MissionEnnemy({
    Key? key,
    required this.missionId,
  }) : super(key: key);

  String getMissionImage() {
    switch (missionId) {
      case 1:
        return 'assets/serveur.png';
      case 2:
        return 'assets/banque.png';
      case 3:
        return 'assets/gouvernement.png';
      default:
        return 'assets/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(getMissionImage(), width: 300),
        ],
      ),
    );
  }
}
