import 'package:flutter/material.dart';

import '../../ui/daily_text.dart';

class HomePagePlans extends StatefulWidget {
  const HomePagePlans({super.key});

  @override
  State<HomePagePlans> createState() => _HomePagePlansState();
}

class _HomePagePlansState extends State<HomePagePlans> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        children: [
          DailyText.text("Planos para hoje").header.small.bold
        ],
      ),
    );
  }
}
