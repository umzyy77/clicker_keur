import 'package:flutter/material.dart';

class ProfileStatRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStatRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent)),
        ],
      ),
    );
  }
}
