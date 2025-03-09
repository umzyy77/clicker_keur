import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/views/create_player_view.dart';
import '../viewmodels/player_viewmodel.dart';
import 'home_view.dart';

class PlayerCreatedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Hacker créé !")),
      body: Center(
        child: playerViewModel.player != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue, ${playerViewModel.player!.username} !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("💻 Puissance de hacking : ${playerViewModel.player!.hackingPower}"),
            Text("💰 Argent : ${playerViewModel.player!.money}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              child: Text("Aller au menu"),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "❌ Échec de la création du joueur.",
              style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePlayerView()),
                );
              },
              child: Text("Réessayer"),
            ),
          ],
        ),
      ),
    );
  }
}
