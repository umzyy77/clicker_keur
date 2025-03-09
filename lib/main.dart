import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled1/viewmodels/player_upgrade_viewmodel.dart';
import 'viewmodels/player_mission_viewmodel.dart';
import 'models/difficulty_model.dart';
import 'models/mission_model.dart';
import 'models/player_mission_model.dart';
import 'models/status_model.dart';
import 'views/mission_game_view.dart';
import 'views/home_view.dart';
import 'widgets/splash_screen.dart';
import 'viewmodels/player_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Charger les variables d’environnement

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerViewModel()..loadPlayer()), // Charger le joueur au lancement
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
        '/mission': (context) => MissionGameView(
          playerMission: PlayerMissionModel(
            player: Provider.of<PlayerViewModel>(context, listen: false).player!,
            mission: MissionModel(
              id: 1,
              name: "Mission Test",
              rewardMoney: 500,
              rewardPower: 5,
              difficulty: DifficultyModel(id: 1, label: "Facile", clicksRequired: 10),
            ),
            status: StatusModel(id: 3, label: "En cours"),
            clicksDone: 0,
          ),
        ),
      },
    );
  }
}