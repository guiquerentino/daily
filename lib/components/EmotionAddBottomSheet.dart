import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import 'AnotherBottomSheet.dart';

class EmotionAddBottomSheet extends StatefulWidget {
  final PageController
      pageController; // Adicione o controlador como um parâmetro

  const EmotionAddBottomSheet({Key? key, required this.pageController});

  @override
  State<EmotionAddBottomSheet> createState() => _EmotionAddBottomSheetState();
}

class _EmotionAddBottomSheetState extends State<EmotionAddBottomSheet> {
  final List<List<Map<String, dynamic>>> emotions = [
    [
      {"imagePath": "assets/emoji_felicidade.png", "name": "Felicidade"},
      {"imagePath": "assets/emoji_ansiedade.png", "name": "Ansiedade"},
      {"imagePath": "assets/emoji_tedio.png", "name": "Tédio"},
    ],
    [
      {"imagePath": "assets/emoji_confusao.png", "name": "Confusão"},
      {"imagePath": "assets/emoji_animacao.png", "name": "Animação"},
      {"imagePath": "assets/emoji_decepcao.png", "name": "Decepção"},
    ],
    [
      {"imagePath": "assets/emoji_apatico.png", "name": "Apático"},
      {"imagePath": "assets/emoji_surpresa.png", "name": "Surpresa"},
      {"imagePath": "assets/emoji_cansaso.png", "name": "Cansaço"},
    ],
    [
      {"imagePath": "assets/emoji_tristeza.png", "name": "Tristeza"},
      {"imagePath": "assets/emoji_foco.png", "name": "Foco"},
      {"imagePath": "assets/emoji_motivado.png", "name": "Motivado"},
    ],
  ];

  int selectedEmotionIndex = -1;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          color: const Color.fromRGBO(245, 245, 245, 1),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "1/4",
                      style: TextStyle(fontSize: 26, fontFamily: 'Pangram'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
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
                        "Como você está se sentindo?",
                        style: TextStyle(fontFamily: 'Pangram', fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Selecione pelo menos uma emoção.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 3.0,
                        )
                      ],
                    ),
                    child: const Row(
                      children: [
                        Gap(10),
                        Icon(
                          Iconsax.search_normal_14,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: "Procurar emoções",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                for (int i = 0; i < emotions.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int j = 0; j < emotions[i].length; j++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                int currentIndex = (i * emotions[i].length) + j;
                                if (selectedEmotionIndex == currentIndex) {
                                  selectedEmotionIndex = -1;
                                } else {
                                  selectedEmotionIndex = currentIndex;
                                }
                              });
                            },
                            child: _buildEmotionContainer(
                              emotions[i][j]["imagePath"],
                              emotions[i][j]["name"],
                              selected: selectedEmotionIndex ==
                                  (i * emotions[i].length) + j,
                            ),
                          ),
                      ],
                    ),
                  ),
                if (selectedEmotionIndex != -1)
                  FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      fixedSize: MaterialStatePropertyAll(Size(220, 40)),
                    ),
                    onPressed: () {
                      widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: const Text(
                      "Continuar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionContainer(String imagePath, String emotionName,
      {bool selected = false}) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 82,
          width: 82,
          decoration: BoxDecoration(
            color: selected
                ? const Color.fromRGBO(90, 24, 154, 0.9)
                : const Color.fromRGBO(0, 0, 0, 0.04),
            shape: BoxShape.circle,
          ),
          child: Image.asset(imagePath),
        ),
        const SizedBox(height: 5),
        Text(
          emotionName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }
}
