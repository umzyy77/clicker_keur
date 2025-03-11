import 'package:flutter/material.dart';
import 'package:untitled1/views/mission_list_view.dart';

void showMissionCompletionDialog(BuildContext context, int missionId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("🎉 Mission Terminée !"),
        content: Text("Bravo ! Vous avez terminé la mission #$missionId"),
        actions: const [
          Center(child: CircularProgressIndicator()),
        ],
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop(); // Fermer la boîte de dialogue
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MissionsListView()));
  });
}
