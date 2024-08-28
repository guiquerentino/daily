import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../core/domain/emotion.dart';
import '../../ui/daily_text.dart';

class EmotionEditBottomSheet extends StatefulWidget {
  final Emotion emotion;
  final PageController pageController;

  const EmotionEditBottomSheet({super.key, required this.emotion, required this.pageController});

  @override
  State<EmotionEditBottomSheet> createState() => _EmotionEditBottomSheetState();
}

class _EmotionEditBottomSheetState extends State<EmotionEditBottomSheet> {
  double _markerValue = 60;

  void _updateMarkerValue(double value) {
    setState(() {
      _markerValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.9,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, size: 32),
            ),
            const Gap(5),
            const Text(
              "Como estava o seu humor?",
              style: TextStyle(
                fontFamily: 'Pangram',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(80),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 120,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Gap(18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.emotion.emotionType = EMOTION_TYPE.BRAVO;
                                widget.pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/emoji_bravo.png"),
                                  DailyText.text("Bravo").body.medium
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.emotion.emotionType = EMOTION_TYPE.TRISTE;
                                widget.pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/emoji_tristeza.png"),
                                  DailyText.text("Triste").body.medium
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.emotion.emotionType = EMOTION_TYPE.NORMAL;
                                widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/emoji_normal.png"),
                                  DailyText.text("Normal").body.medium
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.emotion.emotionType = EMOTION_TYPE.FELIZ;
                                widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/emoji_felicidade.png"),
                                  DailyText.text("Feliz").body.medium
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.emotion.emotionType = EMOTION_TYPE.MUITO_FELIZ;
                                widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/emoji_muito_feliz.png"),
                                  DailyText.text("Muito Feliz").body.medium
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
