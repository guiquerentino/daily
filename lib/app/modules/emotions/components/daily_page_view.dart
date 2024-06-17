import 'package:flutter/material.dart';
import '../../../core/domain/emotion.dart';
import '../pages/tags_add_bottom_sheet.dart';
import '../pages/notes_add_bottom_sheet.dart';

class DailyPageView extends StatefulWidget {
  final Emotion emotion;
  const DailyPageView({super.key, required this.emotion});

  @override
  State<DailyPageView> createState() => _DailyPageViewState();
}

class _DailyPageViewState extends State<DailyPageView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        TagsAddBottomSheet(pageController: _pageController, emotion: widget.emotion),
        NotesAddBottomSheet(
          pageController: _pageController,
          emotion: widget.emotion,
        )
      ],
    );
  }
}
