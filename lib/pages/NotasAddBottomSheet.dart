import 'package:daily/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../entities/Registro.dart';
import '../http/RegistroHttp.dart';

class NotasAddBottomSheet extends StatefulWidget {
  final PageController pageController;
  final Registro registro;
  final Function reloadRegistros;

  const NotasAddBottomSheet(
      {Key? key, required this.pageController, required this.registro, required this.reloadRegistros})
      : super(key: key);

  @override
  State<NotasAddBottomSheet> createState() => _NotasAddBottomSheetState();
}

class _NotasAddBottomSheetState extends State<NotasAddBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _notaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_outlined),
                        onPressed: () {
                          widget.pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut);
                        },
                      ),
                      const Text(
                        "3/3",
                        style: TextStyle(fontSize: 26, fontFamily: 'Pangram'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(30),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "Gostaria de contar mais sobre?",
                          style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Escreva uma nota que reflita a sua emoção.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  const Gap(32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            TextFormField(
                              controller: _notaController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: "Escreva uma nota (opcional)",
                                hintStyle: TextStyle(fontFamily: 'Pangram'),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              maxLines: null,
                              minLines: 8,
                              keyboardType: TextInputType.text,
                              textAlignVertical: TextAlignVertical.top,
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: IconButton(
                                icon: const Icon(Icons.mic),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FilledButton(
                            autofocus: true,
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black),
                              fixedSize:
                                  MaterialStatePropertyAll(Size(220, 40)),
                            ),
                            onPressed: () async {
                              widget.registro.text = _notaController.text;

                              await RegistroHttp()
                                  .salvarRegistro(widget.registro);

                              widget.reloadRegistros();

                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Finalizar",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
