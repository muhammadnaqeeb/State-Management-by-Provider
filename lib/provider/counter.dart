import 'package:flutter/material.dart';

class Counterr extends ChangeNotifier {
  int _counter = 15;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
