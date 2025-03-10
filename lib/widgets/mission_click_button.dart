import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../viewmodels/lightning_viewmodel.dart';

class MissionClickButton extends StatelessWidget {
  final VoidCallback onTap; // Action définie par l'utilisateur

  const MissionClickButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final lightningViewModel = Provider.of<LightningViewModel>(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Laptop cliquable
        Positioned(
          top: 400,
          child: GestureDetector(
            onTap: () {
              lightningViewModel.triggerLightning(); // Joue l'animation d'éclair
              onTap(); // Exécute l'action fournie
            },
            child: Image.asset(
              'assets/laptop.png',
              width: 100,
            ),
          ),
        ),

        // Éclair qui apparaît et disparaît après animation
        if (lightningViewModel.isAnimating)
          Positioned(
            top: 300, // Position d'apparition
            child: Transform.rotate(
              angle: -3.14 * 3 / 4, // 🔄 Rotation exacte de -135°
              child: Lottie.asset(
                'assets/lightning.json',
                width: 150,
                height: 150,
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    lightningViewModel.stopLightning(); // Arrête l'animation après sa durée
                  });
                },
              ),
            ),
          ),
      ],
    );
  }
}
