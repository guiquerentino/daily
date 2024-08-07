import 'package:daily/app/core/domain/external/login_request.dart';
import 'package:daily/app/core/domain/providers/account_provider.dart';
import 'package:daily/app/modules/auth/pages/account_creation_page.dart';
import 'package:daily/app/modules/auth/pages/forgot_password_page.dart';
import 'package:daily/app/modules/emotions/pages/home_page.dart';
import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:daily/app/modules/ui/daily_checkbox.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/daily_login_app_bar.dart';
import '../components/daily_social_login.dart';
import '../../../core/domain/account.dart';
import '../http/auth_http.dart';

class LoginPage extends StatefulWidget {
  final String ROUTE_NAME = '/';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool lembrarDeMim = false;
  bool erroLogin = false;
  bool mostrarSenha = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String? emailValidator(String? value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return 'Por favor, digite um e-mail válido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const LoginAppBar(),
              const Gap(31),
              DailyText.text("Bem-vindo(a) de volta!").header.medium.bold,
              const Gap(20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(236, 236, 236, .7),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                validator: emailValidator,
                                decoration: const InputDecoration(
                                    hintText: "Digite seu e-mail",
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide.none),
                                    fillColor:
                                        Color.fromRGBO(196, 196, 196, 0.20),
                                    suffixIcon: Icon(Icons.email_outlined)),
                              ),
                              const Gap(15),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !mostrarSenha,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Por favor, digite uma senha válida.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Senha",
                                    filled: true,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide.none),
                                    fillColor: const Color.fromRGBO(
                                        196, 196, 196, 0.20),
                                    suffixIcon: IconButton(
                                        icon: mostrarSenha
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            mostrarSenha = !mostrarSenha;
                                          });
                                        })),
                              ),
                              const Gap(15),
                              if (erroLogin)
                                DailyText.text("Usuário ou senha inválidos")
                                    .body
                                    .medium
                                    .danger,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      DailyCheckbox(
                                          value: lembrarDeMim,
                                          onClicked: (bool? value) {
                                            setState(() {
                                              lembrarDeMim = value!;
                                            });
                                          }),
                                      DailyText.text("Lembrar de mim")
                                          .body
                                          .medium,
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Modular.to.navigate(
                                          '/auth${const ForgotPasswordPage().ROUTE_NAME}');
                                    },
                                    child: DailyText.text("Esqueceu a senha?")
                                        .body
                                        .medium,
                                  ),
                                ],
                              ),
                              const Gap(20),
                              DailyButton(
                                text: DailyText.text("Entrar")
                                    .body
                                    .regular
                                    .large
                                    .neutral,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    LoginRequest request = LoginRequest(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        accountType: 0);

                                    Response response = await AuthHttp()
                                        .authorizeAccount(request);
                                    if (response.statusCode == 202) {
                                      if (lembrarDeMim) {
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        await prefs.setString(
                                            'email', _emailController.text);
                                        await prefs.setString('password',
                                            _passwordController.text);
                                      }

                                      Account account = Account.fromJson(
                                          jsonDecode(response.body));

                                      Provider.of<AccountProvider>(context,
                                              listen: false)
                                          .setAccount(account);

                                      if (account.fullName == null ||
                                          account.fullName!.isEmpty) {
                                        Modular.to.navigate('/onboarding');
                                      } else {
                                        Modular.to.navigate(
                                            '/emotions${HomePage.ROUTE_NAME}',
                                            arguments: Account.fromJson(
                                                jsonDecode(response.body)));
                                      }
                                    } else {
                                      setState(() {
                                        erroLogin = true;
                                      });
                                    }
                                  }
                                },
                              ),
                              const Gap(5),
                            ],
                          ),
                        ),
                      ),
                      if (constraints.maxHeight > 680) const DailySocialLogin(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Modular.to.navigate(
                                      '/auth${const AccountCreationPage().ROUTE_NAME}');
                                },
                                child:
                                    DailyText.text("Membro novo? Registre-se")
                                        .header
                                        .small
                                        .regular),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
