import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/meditation.dart';
import '../../ui/daily_text.dart';

class MeditationDetailsPage extends StatefulWidget {
  final Meditation currentMeditation;

  const MeditationDetailsPage({super.key, required this.currentMeditation});

  @override
  State<MeditationDetailsPage> createState() => _MeditationDetailsPageState();
}

class _MeditationDetailsPageState extends State<MeditationDetailsPage> {
  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Modular.to.navigate('/meditation');
                                },
                                icon: const Icon(
                                  Icons.arrow_back_outlined,
                                  size: 30,
                                ),
                              ),
                              DailyText.text("VOLTAR").body
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/${widget.currentMeditation.photoUrl}.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.maxFinite,
                        height: 110,
                        color: const Color.fromRGBO(238, 238, 238, 1),
                        child: const Icon(Icons.broken_image,
                            color: Colors.grey, size: 60),
                      );
                    },
                  ),
                  const Gap(20),
                  DailyText.text(_decodeUtf8(widget.currentMeditation.name))
                      .header
                      .medium
                      .bold,
                  Text(widget.currentMeditation.duration),
                  const Gap(10),
                  Text(
                    _decodeUtf8(widget.currentMeditation.text),
                    style: const TextStyle(fontFamily: 'Pangram'),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: () {
                  Modular.to.navigate('/meditation/play',
                      arguments: widget.currentMeditation);
                },
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(200, 40)),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(158, 181, 103, 1)),
                ),
                child: const Text(
                  "Iniciar",
                  style: TextStyle(fontSize: 18, fontFamily: 'Pangram'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
