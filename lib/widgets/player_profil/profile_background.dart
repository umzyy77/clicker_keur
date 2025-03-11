import 'package:flutter/material.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset("assets/background_profil.png", fit: BoxFit.cover),
    );
  }
}
