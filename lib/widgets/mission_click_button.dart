import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../viewmodels/lightning_viewmodel.dart';

class MissionClickButton extends StatelessWidget {
  final VoidCallback onTap;

  const MissionClickButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final lightningViewModel = Provider.of<LightningViewModel>(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Bouton cliquable
        Positioned(
          bottom: 50, // Ajuste la position
          child: GestureDetector(
            onTap: () {
              lightningViewModel.triggerLightning(); // Ajoute un éclair immédiatement
              onTap(); // Exécute l’action associée au clic
            },
            child: Image.asset(
              'assets/player.png',
              width: 200,
            ),
          ),
        ),

        // Afficher plusieurs éclairs simultanément
        ...lightningViewModel.activeLightnings.map((id) {
          return Positioned(
            bottom: 50 + 100,
            child: Transform.rotate(
              angle: -3.14 * 3 / 4, // Rotation -135°
              child: Lottie.asset(
                'assets/lightning.json',
                width: 150,
                height: 150,
                repeat: false,
              ),
            ),
          );
        }),
      ],
    );
  }
}
