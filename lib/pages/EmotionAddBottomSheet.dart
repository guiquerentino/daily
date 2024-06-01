import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../entities/Registro.dart';

class EmotionAddBottomSheet extends StatefulWidget {
  final PageController pageController;
  late Registro registro;

  EmotionAddBottomSheet(
      {Key? key, required this.pageController, required this.registro});

  @override
  State<EmotionAddBottomSheet> createState() => _EmotionAddBottomSheetState();
}

class _EmotionAddBottomSheetState extends State<EmotionAddBottomSheet> {
  final List<Map<String, dynamic>> allEmotions = [
    {
      "imagePath": "assets/emoji_felicidade.png",
      "name": "Felicidade",
      "emocao": EMOTION_TYPE.FELICIDADE
    },
    {
      "imagePath": "assets/emoji_ansiedade.png",
      "name": "Ansiedade",
      "emocao": EMOTION_TYPE.ANSIEDADE
    },
    {
      "imagePath": "assets/emoji_tedio.png",
      "name": "Tédio",
      "emocao": EMOTION_TYPE.TEDIO
    },
    {
      "imagePath": "assets/emoji_confusao.png",
      "name": "Confusão",
      "emocao": EMOTION_TYPE.CONFUSAO
    },
    {
      "imagePath": "assets/emoji_animacao.png",
      "name": "Animação",
      "emocao": EMOTION_TYPE.ANIMACAO
    },
    {
      "imagePath": "assets/emoji_decepcao.png",
      "name": "Decepção",
      "emocao": EMOTION_TYPE.DECEPCAO
    },
    {
      "imagePath": "assets/emoji_apatico.png",
      "name": "Apático",
      "emocao": EMOTION_TYPE.APATICO
    },
    {
      "imagePath": "assets/emoji_surpresa.png",
      "name": "Surpresa",
      "emocao": EMOTION_TYPE.SURPRESA
    },
    {
      "imagePath": "assets/emoji_cansaso.png",
      "name": "Cansaço",
      "emocao": EMOTION_TYPE.CANSASO
    },
    {
      "imagePath": "assets/emoji_tristeza.png",
      "name": "Tristeza",
      "emocao": EMOTION_TYPE.TRISTEZA
    },
    {
      "imagePath": "assets/emoji_foco.png",
      "name": "Foco",
      "emocao": EMOTION_TYPE.FOCO
    },
    {
      "imagePath": "assets/emoji_motivado.png",
      "name": "Motivado",
      "emocao": EMOTION_TYPE.MOTIVADO
    },
  ];

  List<Map<String, dynamic>> filteredEmotions = [];
  final TextEditingController _searchController = TextEditingController();
  int selectedEmotionIndex = -1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filteredEmotions = allEmotions;
    _searchController.addListener(_filterEmotions);
  }

  void _filterEmotions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEmotions = allEmotions.where((emotion) {
        final emotionName = emotion["name"]!.toLowerCase();
        return emotionName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterEmotions);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "1/3",
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
                          "Como você está se sentindo?",
                          style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Selecione uma emoção.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
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
                      child: Row(
                        children: [
                          const Gap(10),
                          const Icon(
                            Iconsax.search_normal_14,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
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
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: filteredEmotions.map((emotion) {
                      int currentIndex = allEmotions.indexOf(emotion);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedEmotionIndex == currentIndex) {
                              selectedEmotionIndex = -1;
                            } else {
                              selectedEmotionIndex = currentIndex;
                              _scrollController.animateTo(
                                  _scrollController.position.extentTotal,
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                            }
                          });
                        },
                        child: _buildEmotionContainer(
                          emotion["imagePath"]!,
                          emotion["name"]!,
                          selected: selectedEmotionIndex == currentIndex,
                        ),
                      );
                    }).toList(),
                  ),
                  if (selectedEmotionIndex != -1)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FilledButton(
                        autofocus: true,
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          fixedSize: MaterialStatePropertyAll(Size(220, 40)),
                        ),
                        onPressed: () {
                          widget.registro.emotionType =
                              filteredEmotions[selectedEmotionIndex]["emocao"];

                          widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text(
                          "Continuar",
                          style: TextStyle(fontSize: 18),
                        ),
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
