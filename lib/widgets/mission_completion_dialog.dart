import 'package:flutter/material.dart';
import '../views/home_view.dart';

void showMissionCompletionDialog(BuildContext context, int missionId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("🎉 Mission Terminée !"),
        content: Text("Bravo ! Vous avez terminé la mission #$missionId"),
        actions: [
          Center(child: CircularProgressIndicator()),
        ],
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop(); // Fermer la boîte de dialogue
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeView()));
  });
}
