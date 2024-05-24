import 'package:daily/components/AnotherBottomSheet.dart';
import 'package:daily/components/EmotionAddBottomSheet.dart';
import 'package:daily/pages/LoginPage.dart';
import 'package:flutter/material.dart';

class DailyPageView extends StatefulWidget {
  const DailyPageView({super.key});

  @override
  State<DailyPageView> createState() => _DailyPageViewState();
}

class _DailyPageViewState extends State<DailyPageView> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: BouncingScrollPhysics(),
      children: [
        EmotionAddBottomSheet(pageController: _pageController,),
        const AnotherBottomSheet()
      ],
    );
  }
}
