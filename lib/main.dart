import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/enemy_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EnemyViewModel()..fetchEnemy(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker Game',
      home: Scaffold(
        appBar: AppBar(title: Text("Test Enemy ViewModel")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<EnemyViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Text("Ennemi : ${viewModel.enemy.name}"),
                      Text("Vie : ${viewModel.enemy.currentLife} / ${viewModel.enemy.totalLife}"),
                      ElevatedButton(
                        onPressed: () => viewModel.attackEnemy(1),
                        child: Text("Attaquer"),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
