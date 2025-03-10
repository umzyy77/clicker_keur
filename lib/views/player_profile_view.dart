import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/widgets/player_profil/profile_background.dart';
import 'package:untitled1/widgets/player_profil/profile_card.dart';
import 'package:untitled1/widgets/player_profil/profile_header.dart';
import '../viewmodels/player_viewmodel.dart';


class PlayerProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final player = playerViewModel.player;

    if (player == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Aucun joueur trouvé.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackground(),
          ProfileHeader(),
          Center(child: ProfileCard(player: player, playerViewModel: playerViewModel)),
        ],
      ),
    );
  }
}
