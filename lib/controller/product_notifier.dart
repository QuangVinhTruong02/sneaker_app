import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  List<int> _sizeList = [];
  int _index = 0;
  int _quantity = 1;
  int get quantity => _quantity;
  set quantity(int newQuantity) {
    _quantity = newQuantity;
    
  }

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    _quantity--;
    notifyListeners();
  }

  set sizeList(List<int> newList) {
    _sizeList = newList;
    notifyListeners();
  }

  List<int> get sizeList => _sizeList;

  set index(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }

  int get index => _index;

  int get value => _sizeList[_index];

  set checkSize(int value) {
    for (int i = 0; i < sizeList.length; i++) {
      if (sizeList[i] == value) {
        _index = i;
        notifyListeners();
        return;
      }
    }
  }
}
