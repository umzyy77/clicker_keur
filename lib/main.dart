import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled1/widgets/splash_screen.dart';
import 'viewmodels/player_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final playerViewModel = PlayerViewModel();
  await playerViewModel.loadPlayer();

  if (playerViewModel.player != null) {
    print("✅ ID du joueur chargé au démarrage : ${playerViewModel.player!.id}");
  } else {
    print("❌ Aucun joueur chargé au démarrage.");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerViewModel()),
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
