import 'package:flutter/material.dart';
import '../../ui/daily_text.dart';

class DailyHomeAppBar extends StatefulWidget {
  const DailyHomeAppBar({super.key});

  @override
  State<DailyHomeAppBar> createState() => _DailyHomeAppBarState();
}

class _DailyHomeAppBarState extends State<DailyHomeAppBar> {

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu_outlined,
              size: 30,
            )),
        DailyText.text("Página Inicial").header.medium.bold,
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            )),
      ],
    );
  }
}
