import 'package:daily/app/core/domain/external/change_password_request.dart';
import 'package:daily/app/modules/auth/pages/password_code_verification_page.dart';
import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import '../components/daily_login_app_bar.dart';
import '../../../core/domain/account.dart';
import '../http/auth_http.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String ROUTE_NAME = '/forgot-password';

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool erroTrocarSenha = false;
  bool mostrarSenha = false;
  bool mostrarSenhaConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double? fontSize = constraints.maxWidth < 700 ? 12 : 16;
          return SingleChildScrollView(
            child: Column(
              children: [
                const LoginAppBar(),
                const Gap(15),
                const Text(
                  "Redefinição de Senha",
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Por favor, insira seu email para que possamos redefinir sua senha. Será necessário uma etapa de confirmação.",
                    style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(236, 236, 236, .7),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null ||
                                  value == '' ||
                                  !value.contains('@')) {
                                return 'Por favor, digite um e-mail válido.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Digite seu e-mail",
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none),
                                fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                                suffixIcon: Icon(Icons.email_outlined)),
                          ),
                          const Gap(10),
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
                                hintText: "Senha nova",
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
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        mostrarSenha = !mostrarSenha;
                                      });
                                    })),
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: !mostrarSenhaConfirm,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Por favor, digite uma senha válida.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Confirme sua senha nova",
                                filled: true,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromRGBO(196, 196, 196, 0.20),
                                suffixIcon: IconButton(
                                    icon: mostrarSenhaConfirm
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        mostrarSenhaConfirm =
                                            !mostrarSenhaConfirm;
                                      });
                                    })),
                          ),
                          if (erroTrocarSenha)
                            const Text(
                              "Erro ao alterar senha, verifique as informações.",
                              style: TextStyle(color: Colors.red),
                            ),
                          const Gap(30),
                          DailyButton(
                              text: DailyText.text("Redefinir")
                                  .neutral
                                  .body
                                  .large,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ChangePasswordRequest request =
                                      ChangePasswordRequest(
                                          email: _emailController.text,
                                          password: _passwordController.text);

                                  Response response =
                                      await AuthHttp().changePassword(request);

                                  if (response.statusCode == 200) {
                                    Modular.to.navigate(
                                        '/auth${const PasswordCodeVerification().ROUTE_NAME}');
                                  } else {
                                    setState(() {
                                      erroTrocarSenha = true;
                                    });
                                  }
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          onPressed: () {
            Modular.to.navigate('/auth${const LoginPage().ROUTE_NAME}');
          },
          backgroundColor: Color.fromRGBO(53, 56, 63, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_back_outlined,
              color: Colors.white, size: 20.0),
        ),
      ),
    );
  }
}
