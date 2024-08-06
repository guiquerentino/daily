import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/account.dart';
import '../../../core/domain/emotion.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../../core/utils/emoji_utils.dart';
import '../http/emotions_http.dart';

class NotesEditBottomSheet extends StatefulWidget {
  final PageController pageController;
  final Emotion emotion;

  const NotesEditBottomSheet(
      {Key? key, required this.pageController, required this.emotion})
      : super(key: key);

  @override
  State<NotesEditBottomSheet> createState() => _NotesEditBottomSheetState();
}

class _NotesEditBottomSheetState extends State<NotesEditBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _notaController;
  final ValueNotifier<int> _charCount = ValueNotifier<int>(0);
  static const int _maxChars = 255;

  @override
  void initState() {
    super.initState();
    _notaController = TextEditingController(text: widget.emotion.text ?? '');
    _charCount.value = _notaController.text.length;
    _notaController.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    _charCount.value = _notaController.text.length;
  }

  @override
  void dispose() {
    _notaController.removeListener(_updateCharCount);
    _notaController.dispose();
    _charCount.dispose();
    super.dispose();
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
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                hintText: "Escreva uma nota (opcional)",
                                hintStyle: TextStyle(fontFamily: 'Pangram'),
                                filled: true,
                                fillColor: Colors.white,
                                counterText: "",  // Remove default counter
                              ),
                              maxLength: _maxChars,
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
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ValueListenableBuilder<int>(
                              valueListenable: _charCount,
                              builder: (context, count, child) {
                                return Text(
                                  '$count/$_maxChars Caracteres restantes',
                                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.5)),
                                );
                              },
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
                              if (_formKey.currentState!.validate()) {
                                widget.emotion.text = _notaController.text;
                                widget.emotion.ownerId = account!.id;

                                await EmotionsHttp().saveRegister(widget.emotion);

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
                                                  child: EmojisUtils().retornaEmojiEmocao(EMOTION_TYPE.MUITO_FELIZ,false)
                                              ),
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
                                              textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Pangram', fontSize: 14),
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
