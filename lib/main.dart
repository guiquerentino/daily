import 'package:daily/pages/AccountCreationPage.dart';
import 'package:daily/pages/ConfirmEmailCodePage.dart';
import 'package:daily/pages/ForgotPasswordPage.dart';
import 'package:daily/pages/HomePage.dart';
import 'package:daily/pages/LoginPage.dart';
import 'package:daily/pages/PasswordCodeVerificationPage.dart';
import 'package:daily/pages/SplashPage.dart';
import 'package:daily/pages/SuccesfullAccountCreatedPage.dart';
import 'package:daily/pages/SucessfullPasswordChangedPage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (_) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/forgotPassword': (_) => const ForgotPasswordPage(),
        '/passCodeVerification': (_) => const PasswordCodeVerification(),
        '/createAccount': (_) => const AccountCreationPage(),
        '/createAccountCodeVerification': (_) => const ConfirmEmailCodePage(),
        '/sucessfulAccountCreated': (_) => const SucessfullAccountCreatedPage(),
        '/sucessfulPasswordChanged': (_) => const SucessfullPasswordChangedPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
