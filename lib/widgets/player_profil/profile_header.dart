import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      top: screenSize.height * 0.05,
      left: screenSize.width * 0.05,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
