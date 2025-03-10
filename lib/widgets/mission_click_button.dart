import 'package:flutter/material.dart';

class MissionClickButton extends StatelessWidget {
  final VoidCallback onTap;
  final Animation<double> animation;
  final int missionId;

  const MissionClickButton({
    Key? key,
    required this.onTap,
    required this.animation,
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
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(getMissionImage(), width: 300),
            FadeTransition(
              opacity: animation,
              child: Icon(Icons.flash_on, color: Colors.blueAccent, size: 50),
            ),
          ],
        ),
      ),
    );
  }
}
