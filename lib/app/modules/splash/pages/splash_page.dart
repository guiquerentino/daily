import 'dart:async';
import 'dart:convert';

import 'package:daily/app/core/domain/external/login_request.dart';
import 'package:daily/app/modules/auth/pages/login_page.dart';
import 'package:daily/app/modules/emotions/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../auth/http/auth_http.dart';
import '../../../core/domain/account.dart';
import '../../../core/domain/providers/account_provider.dart';

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
    LoginRequest? loginRequest = await AuthHttp().isLogged();
    if (loginRequest != null) {
      Response response = await AuthHttp().authorizeAccount(loginRequest);
      if (response.statusCode == 202) {
        Provider.of<AccountProvider>(context, listen: false)
            .setAccount(Account.fromJson(jsonDecode(response.body)));

        Modular.to.pushNamed('/emotions${HomePage.ROUTE_NAME}',
            arguments: Account.fromJson(jsonDecode(response.body)));
      } else {
        print('1');
        Modular.to.pushNamed('/auth/');
      }
    } else {
      print('2');
      await Future.delayed(Duration(seconds: 3));
      Modular.to.pushNamed('/auth/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(158, 181, 103, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
