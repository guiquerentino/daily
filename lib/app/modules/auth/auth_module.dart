import 'package:daily/app/modules/auth/pages/account_creation_page.dart';
import 'package:daily/app/modules/auth/pages/confirm_email_code_page.dart';
import 'package:daily/app/modules/auth/pages/forgot_password_page.dart';
import 'package:daily/app/modules/auth/pages/login_page.dart';
import 'package:daily/app/modules/auth/pages/password_code_verification_page.dart';
import 'package:daily/app/modules/auth/pages/succesfull_account_created_page.dart';
import 'package:daily/app/modules/auth/pages/sucessfull_password_changed_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
     r.child(const LoginPage().ROUTE_NAME, child: (context) => LoginPage());
     r.child(const ForgotPasswordPage().ROUTE_NAME, child: (context) => ForgotPasswordPage());
     r.child(const AccountCreationPage().ROUTE_NAME, child: (context) => AccountCreationPage());
     r.child(const ConfirmEmailCodePage().ROUTE_NAME, child: (context) => ConfirmEmailCodePage());
     r.child(const PasswordCodeVerification().ROUTE_NAME, child: (context) => PasswordCodeVerification());
     r.child(const SucessfullPasswordChangedPage().ROUTE_NAME, child: (context) => SucessfullPasswordChangedPage());
     r.child(const SucessfullAccountCreatedPage().ROUTE_NAME, child: (context) => SucessfullAccountCreatedPage());
  }
}
