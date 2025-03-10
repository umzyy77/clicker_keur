import 'package:flutter/material.dart';

class MissionClickButton extends StatelessWidget {
  final VoidCallback onTap;

  const MissionClickButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 400,
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(
              'assets/laptop.png',
              width: 10,
            ),
          ),
        ),
      ],
    );
  }
}
