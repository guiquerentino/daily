import 'package:flutter/material.dart';

class CalendarDateProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
