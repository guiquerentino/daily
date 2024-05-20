import 'package:daily/entities/AccountRequest.dart';
import 'package:daily/services/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/DailyLoginAppBar.dart';

class AccountCreationPage extends StatefulWidget {
  const AccountCreationPage({super.key});

  @override
  State<AccountCreationPage> createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _nameController = TextEditingController();
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
                            controller: _nameController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Por favor, digite um nome válido.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Nome",
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none),
                                fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                                suffixIcon: Icon(Icons.abc_sharp)),
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
                                    icon: mostrarSenha ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
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
                                    icon: mostrarSenhaConfirm ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        mostrarSenhaConfirm = !mostrarSenhaConfirm;
                                      });
                                    })),
                          ),
                          const Gap(41),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AccountRequest request = AccountRequest(
                                    fullName: _nameController.text,
                                    accountType: 0,
                                    password: _passwordController.text,
                                    email: _emailController.text);

                                LoginService().createAccount(request);

                                Navigator.of(context).popAndPushNamed(
                                    "/createAccountCodeVerification");
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(220, 40))),
                            child: const Text("Cadastrar",
                                style: TextStyle(fontSize: 18)),
                          ),
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
            Navigator.of(context).popUntil(ModalRoute.withName("/login"));
          },
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
    );
  }
}
