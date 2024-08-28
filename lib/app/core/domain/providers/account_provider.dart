import 'package:daily/app/core/domain/account.dart';
import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  Account? _account;

  Account? get account => _account;

  void setAccount(Account account) {
    _account = account;
    notifyListeners();
  }

  void clearAccount() {
    _account = null;
    notifyListeners();
  }

}