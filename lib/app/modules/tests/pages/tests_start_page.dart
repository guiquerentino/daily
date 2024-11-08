import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/test.dart';
import '../../emotions/components/daily_drawer.dart';

class TestsStartPage extends StatefulWidget {
  final Test test;

  const TestsStartPage({super.key, required this.test});

  @override
  State<TestsStartPage> createState() => _TestsStartPageState();
}

class _TestsStartPageState extends State<TestsStartPage> {
  int _currentQuestionIndex = 0;
  late Map<String, dynamic> _questions;
  List<int> _answers = [];

  @override
  void initState() {
    super.initState();
    _questions = jsonDecode(widget.test.questions);
  }

  @override
  Widget build(BuildContext context) {
    String _decodeUtf8(String text) {
      return utf8.decode(text.codeUnits);
    }

    final questionsList = _questions.values.toList();
    final totalQuestions = questionsList.length;
    final currentQuestion = questionsList[_currentQuestionIndex];

    return Scaffold(
      drawer: const DailyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                if (_currentQuestionIndex == 0)
                  IconButton(
                    onPressed: () {
                      Modular.to.navigate('/tests');
                    },
                    icon: const Icon(Icons.close, size: 30),
                  )
                else
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    },
                    icon: const Icon(Icons.arrow_back_outlined, size: 30),
                  ),
                const Spacer(),
                Text(
                  "${_currentQuestionIndex + 1}/$totalQuestions",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Gap(20),
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / totalQuestions,
              color: const Color.fromRGBO(158, 181, 103, 1),
              backgroundColor: Colors.grey[200],
            ),
            const Gap(20),
            Text(
              _decodeUtf8(currentQuestion['question']),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: currentQuestion['options'].entries.map<Widget>((entry) {
                return GestureDetector(
                  onTap: () {
                    _handleOptionSelection(entry.value);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(entry.key),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOptionSelection(int selectedValue) {
    setState(() {
      _answers.add(selectedValue);

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResults(widget.test.title);
      }
    });
  }

  void _showResults(String testTitle) {
    int totalScore = _answers.reduce((a, b) => a + b);
    Modular.to.navigate('/tests/results?testType=$testTitle', arguments: totalScore);
  }
}
