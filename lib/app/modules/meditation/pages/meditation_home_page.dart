import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/meditation.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_app_bar.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';
import 'package:http/http.dart' as http;

class MeditationHomePage extends StatefulWidget {
  const MeditationHomePage({super.key});

  @override
  State<MeditationHomePage> createState() => _MeditationHomePageState();
}

class _MeditationHomePageState extends State<MeditationHomePage> {
  List<Meditation> meditations = [];

  @override
  void initState() {
    super.initState();
    fetchMeditations();
  }

  Future<void> fetchMeditations() async {

    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/meditation'));
      if (response.statusCode == 200) {
        final List<dynamic> meditationJson = json.decode(response.body);
        setState(() {
          meditations = meditationJson
              .map((json) => Meditation.fromJson(json))
              .toList();
        });
      } else {
        throw Exception('Falha ao carregar meditações');
      }
    } catch (e) {
      print(e.toString());
    }

  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  @override
  Widget build(BuildContext context) {

    final mindfulnessMeditations = meditations
        .where((meditation) => meditation.type == 'Mindfullness')
        .toList();

    final reduceStressMeditations = meditations
        .where((meditation) => meditation.type == 'estresse')
        .toList();

    final anxietyMeditations = meditations
        .where((meditation) => meditation.type == 'ansiedade')
        .toList();


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
              const DailyAppBar(title: "Meditação"),
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
                    GestureDetector(
                      onTap: () {
                      },
                      child: Padding(
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
                    ),
                    Image.asset('assets/article_illustration3.png', height: 100, width: 100),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DailyText.text("Mindfullness").header.small.bold,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  runSpacing: 5,
                  spacing: 10,
                  children: mindfulnessMeditations.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Modular.to.navigate('/meditation/details', arguments: e);
                      },
                      child: Container(
                            width: 140,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/${e.photoUrl}.png', width: 100, height: 100),
                                Text(_decodeUtf8(e.name), style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pangram'), textAlign: TextAlign.center),
                                Text(e.duration, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12,fontFamily: 'Pangram'), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                    );
                  }).toList()
                ),
              ),
              const SizedBox(height: 20),
              DailyText.text("Redução de estresse").header.small.bold,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                    runSpacing: 5,
                    spacing: 10,
                    children: reduceStressMeditations.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Modular.to.navigate('/meditation/details', arguments: e);
                        },
                        child: Container(
                          width: 140,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/${e.photoUrl}.png', width: 100, height: 100),
                              Text(_decodeUtf8(e.name), style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pangram'), textAlign: TextAlign.center),
                              Text(e.duration, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12,fontFamily: 'Pangram'), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    }).toList()
                ),
              ),
              const SizedBox(height: 20),
              DailyText.text("Controle de ansiedade").header.small.bold,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                    runSpacing: 5,
                    spacing: 10,
                    children: anxietyMeditations.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Modular.to.navigate('/meditation/details', arguments: e);
                        },
                        child: Container(
                          width: 140,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/${e.photoUrl}.png', width: 100, height: 100),
                              Text(_decodeUtf8(e.name), style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pangram'), textAlign: TextAlign.center),
                              Text(e.duration, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12,fontFamily: 'Pangram'), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    }).toList()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
