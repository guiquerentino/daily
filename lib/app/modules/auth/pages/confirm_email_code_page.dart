import 'package:daily/app/modules/auth/pages/account_creation_page.dart';
import 'package:daily/app/modules/auth/pages/succesfull_account_created_page.dart';
import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

import '../components/daily_login_app_bar.dart';

class ConfirmEmailCodePage extends StatefulWidget {
  final String ROUTE_NAME = '/confirm-email';

  const ConfirmEmailCodePage({super.key});

  @override
  State<ConfirmEmailCodePage> createState() => _ConfirmEmailCodePageState();
}

class _ConfirmEmailCodePageState extends State<ConfirmEmailCodePage> {
  final controllers = List.generate(5, (_) => TextEditingController());
  final focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
            "Quase lá!",
            style: TextStyle(
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Text(
              "Por favor insira o código de verificação enviado para e**@email.com para confirmar sua conta",
              textAlign: TextAlign.center,
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
                  const Gap(68),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        height: 47,
                        width: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 3)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 4) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index + 1]);
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  const Gap(27),
                  DailyButton(
                      text: DailyText.text("Verificar").body.large.neutral,
                      onPressed: () {
                        Modular.to.navigate(
                            '/auth${const SucessfullAccountCreatedPage().ROUTE_NAME}');
                      }),
                  const Gap(27),
                  const Text(
                    "Não recebeu nenhum código? Enviar novamente",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Enviar novo código em 00:30s",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to
                .navigate('/auth${const AccountCreationPage().ROUTE_NAME}');
          },
          backgroundColor: Color.fromRGBO(53, 56, 63, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
    );
  }
}
