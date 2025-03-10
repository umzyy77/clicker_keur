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
        // Laptop cliquable
        Positioned(
          top: 400,
          child: GestureDetector(
            onTap: () {
              lightningViewModel.triggerLightning(); // Joue un nouvel éclair
              onTap(); // Exécute l'action
            },
            child: Image.asset(
              'assets/laptop.png',
              width: 100,
            ),
          ),
        ),

        // Afficher plusieurs éclairs actifs
        ...lightningViewModel.activeLightnings.map((lightning) {
          return Positioned(
            top: lightning["position"].dy,
            child: Transform.rotate(
              angle: -3.14 * 3 / 4, // -135° de rotation
              child: Lottie.asset(
                'assets/lightning.json',
                width: 150,
                height: 150,
                repeat: false,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
