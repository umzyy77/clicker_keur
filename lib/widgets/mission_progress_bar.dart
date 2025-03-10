import 'package:flutter/material.dart';

class MissionProgressBar extends StatelessWidget {
  final int clicksDone;
  final int? clicksRequired;

  const MissionProgressBar({
    Key? key,
    required this.clicksDone,
    required this.clicksRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: MediaQuery.of(context).size.width / 2 - 75,
      child: Column(
        children: [
          Text(
            clicksRequired != null
                ? "$clicksDone / $clicksRequired"
                : "Chargement...",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: LinearProgressIndicator(
              value: (clicksRequired != null && clicksRequired! > 0)
                  ? clicksDone / clicksRequired!
                  : 0.0,
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
