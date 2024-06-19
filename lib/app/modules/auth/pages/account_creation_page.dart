import 'package:daily/app/core/domain/external/create_account_request.dart';
import 'package:daily/app/modules/auth/pages/confirm_email_code_page.dart';
import 'package:daily/app/modules/auth/pages/login_page.dart';
import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import '../components/daily_login_app_bar.dart';
import '../http/auth_http.dart';

class AccountCreationPage extends StatefulWidget {
  final String ROUTE_NAME = '/create_account';

  const AccountCreationPage({super.key});

  @override
  State<AccountCreationPage> createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool mostrarSenha = false;
  bool mostrarSenhaConfirm = false;

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
      body: Column(
        children: [
          const LoginAppBar(),
          const Gap(31),
          const Text(
            "Criação de conta",
            style: TextStyle(
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Text(
              textAlign: TextAlign.center,
              "Por favor, insira as informações necessárias para a criação da sua conta.",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal),
            ),
          ),
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
                    padding: const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 10.0),
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
                                fillColor: Color.fromRGBO(196, 196, 196, 0.20),
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
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        mostrarSenha = !mostrarSenha;
                                      });
                                    })),
                          ),
                          const Gap(15),
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
                                hintText: "Confirme sua senha",
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
                          const Gap(41),
                          DailyButton(
                              text: DailyText.text("Cadastrar")
                                  .body
                                  .large
                                  .neutral,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {

                                  CreateAccountRequest request =
                                      CreateAccountRequest(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          accountType: 0);

                                  AuthHttp().createAccount(request);

                                  Modular.to.navigate(
                                      '/auth${const ConfirmEmailCodePage().ROUTE_NAME}');
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.navigate('/auth${const LoginPage().ROUTE_NAME}');
          },
          backgroundColor: Color.fromRGBO(53, 56, 63, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
    );
  }
}
