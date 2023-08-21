import 'package:flutter/material.dart';

class ProfileNotifier {
  final Map<int, String> _map = {
    1: "Start selling",
    2: "Purchase history",
    3: "Log out"
  };
  String getPosition(int newValue) {
    String? position;
    _map.forEach((key, value) {
      if (key == newValue) {
        position = value;
      }
    });
    return position!;
  }

  IconData? getIcon(int newValue) {
    switch (newValue) {
      case 1:
        return Icons.store_sharp;
      case 2:
        return Icons.event_note_outlined;
      case 3:
        return Icons.logout_outlined;
      default:
        return null;
    }
  }
}
