import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/views/create_player_view.dart';
import 'package:untitled1/views/home_view.dart';
import '../viewmodels/player_viewmodel.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPlayer(); // ✅ exécuté après le build
    });
  }

  void _checkPlayer() async {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    await playerViewModel.loadPlayer();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => playerViewModel.player != null ? HomeView() : CreatePlayerView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}