import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../viewmodels/lightning_viewmodel.dart';

class LightningView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Consumer<LightningViewModel>(
          builder: (context, lightningViewModel, child) {
            return GestureDetector(
              onTap: () => lightningViewModel.toggleAnimation(),
              child: Lottie.asset(
                lightningViewModel.animationPath,
                width: 200,
                height: 200,
                repeat: true,
                animate: lightningViewModel.isAnimating,
              ),
            );
          },
        ),
      ),
    );
  }
}
