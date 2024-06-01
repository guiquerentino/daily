import 'package:flutter/material.dart';
import '../../../core/domain/Registro.dart';
import '../pages/emotion_add_bottom_sheet.dart';
import '../pages/motivos_add_bottom_sheet.dart';
import '../pages/notas_add_bottom_sheet.dart';

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
