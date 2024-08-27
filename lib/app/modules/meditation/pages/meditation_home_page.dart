import 'package:flutter/material.dart';

import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_app_bar.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';

class MeditationHomePage extends StatefulWidget {
  const MeditationHomePage({super.key});

  @override
  State<MeditationHomePage> createState() => _MeditationHomePageState();
}

class _MeditationHomePageState extends State<MeditationHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      drawer: DailyDrawer(),
      bottomNavigationBar: DailyBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DailyAppBar(title: "Meditação"),
              const SizedBox(height: 8),
              Container(
                height: 116,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DailyText.text("Introdução a Meditação").header.small.bold,
                          const SizedBox(height: 5),
                          DailyText.text("8 mins").body.medium
                        ],
                      ),
                    ),
                    Image.asset('assets/article_illustration3.png', height: 100, width: 100),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
