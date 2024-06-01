import 'package:daily/pages/NotasAddBottomSheet.dart';
import 'package:flutter/material.dart';
import '../entities/Registro.dart';
import '../pages/EmotionAddBottomSheet.dart';
import '../pages/MotivosAddBottomSheet.dart';

class DailyPageView extends StatefulWidget {
  final Function reloadRegistro;

  const DailyPageView({super.key, required this.reloadRegistro});

  @override
  State<DailyPageView> createState() => _DailyPageViewState();
}

class _DailyPageViewState extends State<DailyPageView> {
  final _pageController = PageController();
  final Registro _registro = Registro();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        EmotionAddBottomSheet(
          pageController: _pageController,
          registro: _registro,
        ),
        MotivosAddBottomSheet(
            pageController: _pageController, registro: _registro),
        NotasAddBottomSheet(
            pageController: _pageController,
            registro: _registro,
            reloadRegistros: widget.reloadRegistro)
      ],
    );
  }
}
