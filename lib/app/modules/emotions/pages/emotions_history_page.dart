import 'package:daily/app/modules/emotions/components/daily_drawer.dart';
import 'package:daily/app/modules/emotions/components/daily_emotions_calendar.dart';
import 'package:daily/app/modules/emotions/components/daily_emotions_chart.dart';
import 'package:daily/app/modules/emotions/components/daily_emotions_registers.dart';
import 'package:daily/app/modules/emotions/components/daily_emotions_scoreboard.dart';
import 'package:daily/app/modules/ui/daily_app_bar.dart';
import 'package:daily/app/modules/ui/daily_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class EmotionsHistoryPage extends StatefulWidget {
  static String ROUTE_NAME = '/history';

  const EmotionsHistoryPage({super.key});

  @override
  State<EmotionsHistoryPage> createState() => _HomePageState();
}

class _HomePageState extends State<EmotionsHistoryPage> {
  DateTime dataSelecionada = DateTime.now();

  String formatDate(DateTime date) {
    return DateFormat('E, d MMM', 'pt_BR').format(date);
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != dataSelecionada) {
  //     setState(() {
  //       dataSelecionada = picked;
  //       dataSelecionadaIndex = -1;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      drawer: DailyDrawer(),
      bottomNavigationBar: DailyBottomNavigationBar(),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DailyAppBar(title: "Histórico"),
              Gap(10),
              DailyEmotionsCalendar(),
              Gap(10),
              DailyEmotionRegisters(),
              DailyEmotionsCharts(),
              DailyEmotionsScoreboard(),
            ],
          ),
        ),
      ),
    );
  }
}

