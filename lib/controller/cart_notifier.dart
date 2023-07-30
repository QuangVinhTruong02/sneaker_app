import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  bool _isAllChecked = false;
  int _total = 0;

  set amount(int newAmount) {
    _total = newAmount;
  }

  int get getTotal => _total;

  void total(int newTotal, bool checked) {
    if (checked == true) {
      _total += newTotal;
    } else {
      if (_total > 0) {
        _total -= newTotal;
      }
    }
    notifyListeners();
  }

  set isAllChecked(bool newValue) {
    _isAllChecked = newValue;
    notifyListeners();
  }

  bool get isAllChecked => _isAllChecked;
}
