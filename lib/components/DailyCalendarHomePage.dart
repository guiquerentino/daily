import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DailyCalendarHomePage extends StatefulWidget {
  const DailyCalendarHomePage({super.key});

  @override
  State<DailyCalendarHomePage> createState() => _DailyCalendarHomePageState();
}

class _DailyCalendarHomePageState extends State<DailyCalendarHomePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: () {
          }, child: const Icon(Icons.menu, size: 38, color: Colors.black,)),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(213, 212, 223, 1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(3),
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text("9", style: TextStyle(fontSize: 10),),),
        const Gap(12),
        Container(
          alignment: Alignment.center,
          width: 42,
          height: 43,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 168, 0, 1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: SvgPicture.asset('assets/avatar.svg')),
      ],
    );
  }
}
