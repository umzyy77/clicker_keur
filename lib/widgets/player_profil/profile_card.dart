import 'package:flutter/material.dart';
import 'package:untitled1/widgets/player_profil/profile_delete_button.dart';
import 'package:untitled1/widgets/player_profil/profile_stat_row.dart';

import '../../viewmodels/player_viewmodel.dart';

class ProfileCard extends StatelessWidget {
  final dynamic player;
  final PlayerViewModel playerViewModel;
  final Color redAccentColor = Colors.redAccent;

  ProfileCard({required this.player, required this.playerViewModel});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width > 600 ? 500 : screenSize.width * 0.9,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: redAccentColor, width: 2),
        boxShadow: [BoxShadow(color: redAccentColor.withOpacity(0.5), blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            player.username.toUpperCase(),
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 15),
          ProfileStatRow(label: "💻 Puissance de hacking", value: "${player.hackingPower}"),
          ProfileStatRow(label: "💰 Argent", value: "${player.money}"),
          SizedBox(height: 30),
          ProfileDeleteButton(playerViewModel: playerViewModel),
        ],
      ),
    );
  }
}
