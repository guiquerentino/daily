import 'package:daily/app/modules/emotions/components/daily_page_view.dart';
import 'package:daily/app/modules/emotions/pages/tags_add_bottom_sheet.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/emotion.dart';

class DailyEmotionSelector extends StatefulWidget {
  const DailyEmotionSelector({super.key});

  @override
  State<DailyEmotionSelector> createState() => _DailyEmotionSelectorState();
}

void _showAddEmotionBottomSheet(BuildContext context, Emotion emotion) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DailyPageView(
          emotion: emotion,
        );
      });
}

class _DailyEmotionSelectorState extends State<DailyEmotionSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 120,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DailyText.text("Como você está se sentindo?").bold.header.small,
              const Gap(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Emotion emotion = new Emotion();
                      emotion.emotionType = EMOTION_TYPE.BRAVO;
                      _showAddEmotionBottomSheet(context, emotion);
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
                      Emotion registro = new Emotion();
                      registro.emotionType = EMOTION_TYPE.TRISTE;
                      _showAddEmotionBottomSheet(context, registro);                    },
                    child: Column(
                      children: [
                        Image.asset("assets/emoji_tristeza.png"),
                        DailyText.text("Triste").body.medium
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Emotion emotion = new Emotion();
                      emotion.emotionType = EMOTION_TYPE.NORMAL;
                      _showAddEmotionBottomSheet(context, emotion);                    },
                    child: Column(
                      children: [
                        Image.asset("assets/emoji_normal.png"),
                        DailyText.text("Normal").body.medium
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Emotion emotion = new Emotion();
                      emotion.emotionType = EMOTION_TYPE.FELIZ;
                      _showAddEmotionBottomSheet(context, emotion);                    },
                    child: Column(
                      children: [
                        Image.asset("assets/emoji_felicidade.png"),
                        DailyText.text("Feliz").body.medium
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Emotion registro = new Emotion();
                      registro.emotionType = EMOTION_TYPE.MUITO_FELIZ;
                      _showAddEmotionBottomSheet(context, registro);                    },
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
    );
  }
}
