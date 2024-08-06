import 'package:flutter/material.dart';

class CalendarDateProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  bool _isFirstSelection = true;

  DateTime get selectedDate => _selectedDate;
  bool get isFirstSelection => _isFirstSelection;

  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  set isFirstSelection(bool boolean){
    _isFirstSelection = boolean;
    notifyListeners();
  }
}
