import 'package:daily/app/core/utils/emoji_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/account.dart';
import '../../../core/domain/emotion.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../http/emotions_http.dart';
import 'package:http/http.dart' as http;

class NotesAddBottomSheet extends StatefulWidget {
  final PageController pageController;
  final Emotion emotion;

  const NotesAddBottomSheet(
      {Key? key, required this.pageController, required this.emotion})
      : super(key: key);

  @override
  State<NotesAddBottomSheet> createState() => _NotasAddBottomSheetState();
}

class _NotasAddBottomSheetState extends State<NotesAddBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _notaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> completeRegisterGoal() async {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;

    List<String> completedGoals = account?.completedGoals ?? [];

    if (!completedGoals.contains('registro')) {
      completedGoals.add('registro');

      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8080/api/v1/account/goals?goal=registro&userId=${account!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }
    if (!completedGoals.contains('meta')) {
      completedGoals.add('meta');

      final secondResponse = await http.put(
        Uri.parse(
            'http://10.0.2.2:8080/api/v1/account/goals?goal=meta&userId=${account!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }

    account?.completedGoals = completedGoals;
  }

  @override
  Widget build(BuildContext context) {
    Account? account = Provider.of<AccountProvider>(context).account;

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
                              widget.emotion.text = _notaController.text;
                              widget.emotion.ownerId = account!.id;

                              await EmotionsHttp().saveRegister(widget.emotion);
                              completeRegisterGoal();

                              if (mounted) {
                                Navigator.of(context).pop();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.orange.shade200,
                                                  Colors.pink.shade100
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            child: Center(
                                                child: EmojisUtils()
                                                    .retornaEmojiEmocao(
                                                        EMOTION_TYPE
                                                            .MUITO_FELIZ,
                                                        false)),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Você está no caminho certo!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Pangram',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Continue realizando registros e entenda melhor suas emoções',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Pangram',
                                                fontSize: 14),
                                          ),
                                          const SizedBox(height: 30),
                                        ],
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: double.maxFinite,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    158, 181, 103, 1),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: const Text("Continuar",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Pangram',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
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
