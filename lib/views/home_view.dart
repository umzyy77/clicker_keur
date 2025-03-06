import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Hacking Clicker")),
      body: Center(
        child: playerViewModel.isLoading
            ? CircularProgressIndicator()
            : playerViewModel.player == null
            ? Text("Aucun joueur trouvé", style: TextStyle(fontSize: 18))
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue, ${playerViewModel.player!.username} !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("💻 Puissance de hacking : ${playerViewModel.player!.hackingPower}"),
            Text("💰 Argent : ${playerViewModel.player!.money}"),
          ],
        ),
      ),
    );
  }
}
