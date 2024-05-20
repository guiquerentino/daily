import 'package:daily/components/DailySocialLogin.dart';
import 'package:daily/entities/AccountRequest.dart';
import 'package:daily/services/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:daily/components/DailyLoginAppBar.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
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
    initializeState();
  }

  Future<void> initializeState() async {
    AccountRequest? accountRequest = await LoginService().isLogged();

    if (accountRequest != null) {
      Response response = await LoginService().authorizeAccount(accountRequest);
      if (response.statusCode == 202) {
        Navigator.of(context).popAndPushNamed("/home",
            arguments: AccountRequest.fromJson(jsonDecode(response.body)));
      }
    }
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
                const Text(
                  "Bem-vindo(a) de volta!",
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
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
                          padding: const EdgeInsets.fromLTRB(
                              16.0, 45.0, 16.0, 10.0),
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
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          borderSide: BorderSide.none),
                                      fillColor: Color.fromRGBO(
                                          196, 196, 196, 0.20),
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
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          borderSide: BorderSide.none),
                                      fillColor:
                                      const Color.fromRGBO(196, 196, 196, 0.20),
                                      suffixIcon: IconButton(
                                          icon: mostrarSenha
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                              Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              mostrarSenha = !mostrarSenha;
                                            });
                                          })),
                                ),
                                const Gap(15),
                                if (erroLogin)
                                  const Text("Usuário ou senha inválidos!",
                                      style: TextStyle(color: Colors.red),
                                      textAlign: TextAlign.start),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: Colors.black,
                                            value: lembrarDeMim,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                lembrarDeMim = value!;
                                              });
                                            }),
                                        const Text("Lembrar de mim",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed("/forgotPassword");
                                      },
                                      child: const Text("Esqueci minha senha",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                FilledButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      AccountRequest request = AccountRequest(
                                          accountType: 0,
                                          email: _emailController.text,
                                          password: _passwordController.text);

                                      Response response = await LoginService()
                                          .authorizeAccount(request);
                                      if (response.statusCode == 202) {
                                        if (lembrarDeMim) {
                                          final prefs =
                                          await SharedPreferences.getInstance();

                                          await prefs.setString(
                                              'email', _emailController.text);
                                          await prefs.setString(
                                              'password',
                                              _passwordController.text);
                                        }

                                        Navigator.of(context).popAndPushNamed(
                                            "/home",
                                            arguments: AccountRequest.fromJson(
                                                jsonDecode(response.body)));
                                      } else {
                                        setState(() {
                                          erroLogin = true;
                                        });
                                      }
                                    }
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                      fixedSize:
                                      MaterialStatePropertyAll(Size(220, 40))),
                                  child: const Text("Entrar",
                                      style: TextStyle(fontSize: 18)),
                                ),
                                const Gap(5),
                              ],
                            ),
                          ),
                        ),
                        if(constraints.maxHeight > 680)
                          const DailySocialLogin(),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/createAccount");
                                  },
                                  child: const Text("Membro novo? Registre-se",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400))),
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


