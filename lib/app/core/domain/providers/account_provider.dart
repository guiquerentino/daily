import 'dart:convert';
import 'dart:typed_data';

import 'package:daily/app/core/domain/account.dart';
import 'package:daily/app/core/domain/external/change_account_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> updateProfilePhoto(Uint8List newPhoto, int userId) async {
    if (_account != null) {
      _account!.profilePhoto = newPhoto;
      notifyListeners();

      String base64Image = base64Encode(newPhoto);

      final response = await http.put(
        Uri.parse('http://10.0.2.2:8080/api/v1/account/profile-photo?userId=$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'image': base64Image}),
      );
    }
  }

  Future<void> updateAccount(int userId, String fullName, String email, int gender) async {

    ChangeAccountRequest request = new ChangeAccountRequest(userId: userId, fullName: fullName, email: email, gender: gender);

    final response = await http.put(
      Uri.parse('http://10.0.2.2:8080/api/v1/account/update-profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson())
    );

    if(response == 200){
      _account!.email = email;
      _account!.fullName = fullName;
      _account!.gender = gender;

      notifyListeners();
    }

  }


}
