import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _position = 0;

  set position(int newIndex) {
    _position = newIndex;
    notifyListeners();
  }

  int get position => _position;

  



 
}
