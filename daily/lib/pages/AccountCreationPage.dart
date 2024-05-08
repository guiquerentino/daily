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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          const Gap(15),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Por favor, digite uma senha válida.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Senha",
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none),
                                fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                                suffixIcon: Icon(Icons.lock_outline)),
                          ),
                          const Gap(15),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Por favor, digite uma senha válida.';
                              }

                              if (value != _passwordController.text) {
                                return 'As senhas não coincidem';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Confirme sua nova senha",
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none),
                                fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                                suffixIcon: Icon(Icons.lock_outline)),
                          ),
                          const Gap(41),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('Email: ${_emailController.text}');
                                print('Senha: ${_passwordController.text}');

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
            Navigator.of(context).pop();
          },
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
    );
  }
}
