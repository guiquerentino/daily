import 'dart:async';
import 'dart:convert';

import 'package:daily/app/modules/auth/pages/login_page.dart';
import 'package:daily/app/modules/emotions/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

import '../../modules/auth/http/auth_http.dart';
import '../domain/account_request.dart';

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
    await Future.delayed(const Duration(seconds: 3));

    AccountRequest? accountRequest = await AuthHttp().isLogged();
    if (accountRequest != null) {
      Response response = await AuthHttp().authorizeAccount(accountRequest);
      if (response.statusCode == 202) {
        Modular.to.navigate('/emotions${HomePage.ROUTE_NAME}', arguments: AccountRequest.fromJson(jsonDecode(response.body)));
      }
    } else {
    Modular.to.navigate('/auth${const LoginPage().ROUTE_NAME}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/raccoon.svg'),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
