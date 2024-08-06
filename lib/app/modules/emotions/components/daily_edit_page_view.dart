import 'package:daily/app/modules/emotions/pages/emotion_edit_bottom_sheet.dart';
import 'package:daily/app/modules/emotions/pages/notes_edit_bottom_sheet.dart';
import 'package:daily/app/modules/emotions/pages/tags_edit_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../core/domain/emotion.dart';

class DailyEditPageView extends StatefulWidget {
  final Emotion emotion;
  const DailyEditPageView({super.key, required this.emotion});

  @override
  State<DailyEditPageView> createState() => _DailyEditPageViewState();
}

class _DailyEditPageViewState extends State<DailyEditPageView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        EmotionEditBottomSheet(emotion: widget.emotion, pageController: _pageController,),
        TagsEditBottomSheet(pageController: _pageController, emotion: widget.emotion),
        NotesEditBottomSheet(
          pageController: _pageController,
          emotion: widget.emotion,
        )
      ],
    );
  }
}
