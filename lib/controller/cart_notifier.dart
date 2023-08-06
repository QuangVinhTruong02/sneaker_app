import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  bool _isAllChecked = false;
  int _total = 0;

  set setAllChecked(bool check) {
    if (check == true) {
      _isAllChecked = true;
    }
  }

  set amount(int newAmount) {
    _total = newAmount;
  }

  int get getTotal => _total;

  set setTotal(int newValue) {
    _total = 0;
  }

  void total(int newTotal, bool checked) {
    if (checked == true) {
      _total += newTotal;
    } else {
      if (_total > 0) {
        _total -= newTotal;
      }
    }
    if (_total == 0) {
      _isAllChecked = false;
    }
    notifyListeners();
  }

  set isAllChecked(bool newValue) {
    _isAllChecked = newValue;
    //notifyListeners();
  }

  bool get isAllChecked => _isAllChecked;
}
