import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'widgets/splash_screen.dart';
import 'viewmodels/player_viewmodel.dart';
import 'view/upgrade_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerViewModel()..loadPlayer()),
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
      home: Consumer<PlayerViewModel>(
        //
        builder: (context, playerViewModel, child) {
          if (playerViewModel.isLoading) {
            return const SplashScreen();
          } else {
            return UpgradeView(playerId: playerViewModel.player.id);
          }
        },
      ),
    );
  }
}
