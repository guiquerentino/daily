import 'package:daily/app/modules/ui/daily_app_bar.dart';
import 'package:daily/app/modules/ui/daily_bottom_navigation_bar.dart';
import 'package:daily/app/modules/emotions/components/daily_drawer.dart';
import 'package:daily/app/modules/emotions/components/daily_emotion_selector.dart';
import 'package:daily/app/modules/emotions/components/home_page_articles.dart';
import 'package:daily/app/modules/emotions/components/home_page_plans.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String ROUTE_NAME = '/';

  const HomePage({super.key, required user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      drawer: const DailyDrawer(),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DailyAppBar(title: "Página Inicial"),
              const HomePageArticles(),
              const DailyEmotionSelector(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 170,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/may.png"),
                            const Text(
                              "Conversar com\na May",
                              style: TextStyle(
                                  fontFamily: 'Pangram',
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 170,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/chat.png"),
                            const Text(
                              "Chat",
                              style: TextStyle(
                                  fontFamily: 'Pangram',
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HomePagePlans()
            ],
          ),
        ),
      ),
    );
  }
}
