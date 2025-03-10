import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/enemy_viewmodel.dart';

class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EnemyViewModel>(context);

    return viewModel.isLoading
        ? const CircularProgressIndicator()
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          viewModel.enemy.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Barre de vie
        Stack(
          children: [
            Container(
              width: 200,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
            ),
            Container(
              width: (viewModel.enemy.currentLife / viewModel.enemy.totalLife) * 200,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => viewModel.attackEnemy(1),
          child: const Text("Attaquer"),
        ),
      ],
    );
  }
}
