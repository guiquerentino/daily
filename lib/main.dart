import 'package:daily/pages/AccountCreationPage.dart';
import 'package:daily/pages/ConfirmEmailCodePage.dart';
import 'package:daily/pages/ForgotPasswordPage.dart';
import 'package:daily/pages/LoginPage.dart';
import 'package:daily/pages/PasswordCodeVerificationPage.dart';
import 'package:daily/pages/SuccesfullAccountCreatedPage.dart';
import 'package:daily/pages/SucessfullPasswordChangedPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const LoginPage(),
        '/forgotPassword': (_) => const ForgotPasswordPage(),
        '/passCodeVerification': (_) => const PasswordCodeVerification(),
        '/createAccount': (_) => const AccountCreationPage(),
        '/createAccountCodeVerification': (_) => const ConfirmEmailCodePage(),
        '/sucessfulAccountCreated': (_) => const SucessfullAccountCreatedPage(),
        '/sucessfulPasswordChanged': (_) => const SucessfullPasswordChangedPage()
      },
    );
  }
}
