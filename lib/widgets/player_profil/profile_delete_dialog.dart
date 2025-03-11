import 'package:flutter/material.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../views/create_player_view.dart';

void showDeleteConfirmation(BuildContext context, PlayerViewModel playerViewModel) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("⚠️ Supprimer le joueur ?", style: TextStyle(color: Colors.redAccent)),
      content: const Text(
        "Cette action est irréversible. Êtes-vous sûr de vouloir supprimer votre joueur ?",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Annuler", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () async {
            await playerViewModel.deletePlayer();
            Navigator.of(context).pop();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => CreatePlayerView()),
                  (route) => false, // Supprime toutes les routes précédentes
            );
          },
          child: const Text("Supprimer", style: TextStyle(color: Colors.redAccent)),
        ),
      ],
    ),
  );
}
