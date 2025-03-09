import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import '../views/home_view.dart';
import '../views/create_player_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPlayer();
  }

  void _checkPlayer() async {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    await playerViewModel.loadPlayer();

    Future.delayed(Duration(seconds: 2), () {
      if (playerViewModel.player != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeView()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CreatePlayerView()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
