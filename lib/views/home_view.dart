import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import 'create_player_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("🏠 Menu Principal")),
      body: Center(
        child: playerViewModel.player != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "👤 Joueur : ${playerViewModel.player!.username}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("💻 Puissance de hacking : ${playerViewModel.player!.hackingPower}"),
            Text("💰 Argent : ${playerViewModel.player!.money}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await playerViewModel.deletePlayer();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePlayerView()),
                );
              },
              child: Text("🔴 Supprimer mon hacker"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
