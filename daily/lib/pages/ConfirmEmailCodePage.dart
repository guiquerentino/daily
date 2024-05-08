import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/DailyLoginAppBar.dart';

class ConfirmEmailCodePage extends StatefulWidget {
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
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 4) {
                                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  const Gap(27),
                  ElevatedButton(
                    onPressed: () {
                      String code = controllers.map((e) => e.text).join();
                      print("Código digitado: $code");

                      Navigator.of(context).popAndPushNamed("/sucessfulAccountCreated");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.black),
                        fixedSize:
                        MaterialStateProperty.all(const Size(220, 40))),
                    child: const Text("Verificar",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  const Gap(27),
                  const Text("Não recebeu nenhum código? Enviar novamente", style: TextStyle(fontWeight: FontWeight.bold),),
                  const Text("Enviar novo código em 00:30s", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.black,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
    );
  }
}