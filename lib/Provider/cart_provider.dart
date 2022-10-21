import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  void shouldRefresh() {
    notifyListeners();
  }
}
