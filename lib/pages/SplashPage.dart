import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

import '../entities/AccountRequest.dart';
import '../services/LoginService.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    AccountRequest? accountRequest = await LoginService().isLogged();
    if (accountRequest != null) {
      Response response = await LoginService().authorizeAccount(accountRequest);
      if (response.statusCode == 202) {
        Navigator.of(context).pushReplacementNamed("/home",
            arguments: AccountRequest.fromJson(jsonDecode(response.body)));
      }
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/raccoon.svg'),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
