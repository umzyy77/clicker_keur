import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'viewmodels/mission_viewmodel.dart';
import 'viewmodels/player_upgrade_viewmodel.dart';
import 'viewmodels/player_mission_viewmodel.dart';
import 'models/difficulty_model.dart';
import 'models/mission_model.dart';
import 'models/player_mission_model.dart';
import 'models/status_model.dart';
import 'views/mission_game_view.dart';
import 'views/home_view.dart';
import 'widgets/splash_screen.dart';
import 'viewmodels/player_viewmodel.dart';
import 'viewmodels/player_mission_viewmodel.dart'; // 🔹 Ajout du PlayerMissionViewModel

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Charger les variables d’environnement

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerViewModel()..loadPlayer()), // Charger le joueur au lancement
        ChangeNotifierProvider(create: (context) => MissionViewModel()),
        ChangeNotifierProvider(create: (context) => PlayerMissionViewModel()),
        ChangeNotifierProvider(create: (context) => PlayerUpgradeViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hacking Clicker',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeView(),
      },
    );
  }
}