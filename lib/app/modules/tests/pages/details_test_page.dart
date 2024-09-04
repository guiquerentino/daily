import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/test.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';

class DetailsTestPage extends StatefulWidget {
  final Test test;
  const DetailsTestPage({super.key, required this.test});

  @override
  State<DetailsTestPage> createState() => _DetailsTestPageState();
}

class _DetailsTestPageState extends State<DetailsTestPage> {

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DailyDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Modular.to.navigate('/tests');
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        size: 30,
                      ),
                    ),
                    DailyText.text("VOLTAR").body
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(widget.test.bannerUrl, fit: BoxFit.fill,
                            width: double.infinity),
                        const Gap(10),
                        Text(
                          _decodeUtf8(widget.test.title),
                          style: const TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pangram'),
                          textAlign: TextAlign.start,
                        ),
                        const Gap(10),
                        Text(
                          _decodeUtf8(widget.test.text),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Pangram'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: () {
                  Modular.to.navigate('/tests/start', arguments: widget.test);
                },
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(200, 40)),
                  backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(158, 181, 103, 1)),
                ),
                child: const Text(
                  "Iniciar teste",
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
