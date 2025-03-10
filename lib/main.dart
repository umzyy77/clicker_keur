import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled1/viewmodels/upgrade_viewmodel.dart';
import 'models/lightning_model.dart';
import 'viewmodels/lightning_viewmodel.dart';
import 'viewmodels/mission_viewmodel.dart';

import 'viewmodels/player_mission_viewmodel.dart';

import 'views/home_view.dart';
import 'widgets/splash_screen.dart';
import 'viewmodels/player_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerViewModel()..loadPlayer()),
        ChangeNotifierProvider(create: (context) => MissionViewModel()),
        ChangeNotifierProvider(create: (context) => PlayerMissionViewModel()),
        ChangeNotifierProvider(create: (context) => UpgradeViewModel()),
        ChangeNotifierProvider(create: (context) => LightningViewModel(
            lightningModel: LightningModel(
              animationPath: 'assets/lightning.json',
            ),
          ),
        ),

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