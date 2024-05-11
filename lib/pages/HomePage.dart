import 'package:daily/components/DailyCalendarHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DailyCalendarHomePage(),
            const Gap(15),
            RichText(
                text: const TextSpan(
                    text: "Olá,",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                    children: <TextSpan>[
                  TextSpan(
                      text: " Guilherme!",
                      style: TextStyle(color: Color.fromRGBO(0, 70, 195, 1)))
                ])),
            const Text("abaixo estão os seus registros de emoções do dia."),
            const Gap(20),
            Container(
              width: double.maxFinite,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 3.0)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                  SvgPicture.asset('assets/happy.svg'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
