import 'package:flutter/material.dart';
import 'profile_delete_dialog.dart';
import '../../viewmodels/player_viewmodel.dart';

class ProfileDeleteButton extends StatelessWidget {
  final PlayerViewModel playerViewModel;

  ProfileDeleteButton({required this.playerViewModel});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => showDeleteConfirmation(context, playerViewModel),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(0.5), blurRadius: 10)],
          ),
          child: Text(
            "Supprimer mon joueur",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
