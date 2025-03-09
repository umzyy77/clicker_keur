import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'widgets/splash_screen.dart';
import 'viewmodels/player_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Charger les variables d’environnement

  final playerViewModel = PlayerViewModel();
  await playerViewModel.loadPlayer(); // Charger le joueur avant de lancer l'application

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => playerViewModel),
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
      home: SplashScreen(),
    );
  }
}
