import 'package:flutter/cupertino.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}