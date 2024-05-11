import 'package:daily/components/DailySocialLogin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:daily/components/DailyLoginAppBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool lembrarDeMim = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          const Gap(40),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          fontSize: 14,
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
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                          const Gap(41),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).popAndPushNamed("/home");
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
                          const Gap(15),
                          const Text(
                            "ou entre com",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),
                  ),
                  const DailySocialLogin(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/createAccount");
                            },
                            child: const Text("Membro novo? Registre-se",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
