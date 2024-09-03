import 'package:flutter/material.dart';
import 'daily_text.dart';

class DailyAppBar extends StatefulWidget {
  final String title;
  const DailyAppBar({super.key, required this.title});

  @override
  State<DailyAppBar> createState() => _DailyHomeAppBarState();
}

class _DailyHomeAppBarState extends State<DailyAppBar> {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
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
            DailyText.text(widget.title).header.medium.bold,
            Container(),
            Container(),
          ],
        ),
      ],
    );
  }
}
