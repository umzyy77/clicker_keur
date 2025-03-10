import 'package:flutter/material.dart';

class ShopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🛒 Boutique")),
      body: Center(
        child: Text(
          "La boutique sera bientôt disponible !",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
