import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';
import 'package:untitled1/views/game_view.dart';
import 'core/config/config.dart';
import 'viewmodels/user_viewmodel.dart';

Future main() async {
  await Config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        //ChangeNotifierProvider(create: (context) => PlayerViewModel()),
        ChangeNotifierProvider(create: (context) => EnemyViewModel()..fetchEnemy())
      ],
      child: MaterialApp(
        title: 'Slime clicker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameView(),
      ),
    );
  }
}