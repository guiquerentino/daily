import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DailyCalendarHomePage extends StatefulWidget {
  const DailyCalendarHomePage({super.key});

  @override
  State<DailyCalendarHomePage> createState() => _DailyCalendarHomePageState();
}

class _DailyCalendarHomePageState extends State<DailyCalendarHomePage> {
  int selectedContainerIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 8; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                if (selectedContainerIndex == i) {
                  selectedContainerIndex = -1;
                } else {
                  selectedContainerIndex = i;
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: selectedContainerIndex == i
                      ? Colors.black
                      : const Color.fromRGBO(213, 212, 223, 1),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                "9",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
      ],
    );
  }
}
