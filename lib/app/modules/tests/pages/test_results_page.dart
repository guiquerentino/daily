import 'dart:convert';

import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class TestResultsPage extends StatefulWidget {
  final int results;
  final String testType;

  const TestResultsPage({super.key, required this.results, required this.testType});

  @override
  State<TestResultsPage> createState() => _TestResultsPageState();
}

class _TestResultsPageState extends State<TestResultsPage> {
  @override
  Widget build(BuildContext context) {

    String _decodeUtf8(String text) {
      return utf8.decode(text.codeUnits);
    }

    String getFeedbackMessage(int score, String testType) {

      testType = _decodeUtf8(testType);

      if (testType == "Teste de Depressão Simplificado") {
        if (score <= 10) {
          return "Você está indo bem! Sua pontuação sugere que você está lidando bem com os desafios da vida. Continue cuidando de sua saúde mental e mantenha práticas positivas no seu dia a dia.";
        } else if (score <= 20) {
          return "Sua pontuação indica que você pode estar enfrentando alguns desafios. É importante prestar atenção em como você está se sentindo. Considere conversar com um amigo ou profissional sobre o que você está passando.";
        } else if (score <= 30) {
          return "Sua pontuação sugere que você pode estar passando por uma fase difícil. Seria bom buscar apoio, seja de amigos, familiares ou um profissional de saúde mental.";
        } else {
          return "Sua pontuação indica que você pode estar enfrentando uma depressão significativa. É altamente recomendável procurar apoio profissional para ajudar a gerenciar seus sentimentos e melhorar seu bem-estar.";
        }
      } else if (testType == "Teste de Ansiedade") {
        if (score <= 10) {
          return "Sua pontuação está em um nível baixo, indicando que você provavelmente está lidando bem com situações estressantes. Continue gerenciando o estresse e aproveite momentos de relaxamento.";
        } else if (score <= 20) {
          return "Sua pontuação sugere um nível moderado de ansiedade. Pode ser útil adotar técnicas de relaxamento, como meditação ou exercícios de respiração, para ajudar a reduzir o estresse.";
        } else if (score <= 30) {
          return "Sua pontuação indica um nível elevado de ansiedade. É importante considerar estratégias para gerenciar o estresse, como praticar atividades físicas regulares e falar com alguém de confiança.";
        } else {
          return "Sua pontuação indica um nível muito alto de ansiedade. É altamente recomendável procurar ajuda de um profissional de saúde mental para encontrar maneiras eficazes de lidar com essa situação.";
        }
      } else {
        return "Pontuação não reconhecida para o tipo de teste. Por favor, revise os resultados.";
      }
    }

    Color getScoreColor(int score) {
      if (score <= 10) {
        return Colors.green;
      } else if (score <= 20) {
        return Colors.yellow[700]!;
      } else if (score <= 30) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Modular.to.navigate('/tests/');
                  },
                  icon: const Icon(Icons.close, size: 32),
                ),
                const Spacer(),
                DailyText.text("Seus Resultados").header.medium.bold,
                const Spacer(),
              ],
            ),
            const Gap(30),
            Text(
              _decodeUtf8(widget.testType),
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pangram',
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            // Círculo com a pontuação
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getScoreColor(widget.results),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "${widget.results}",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(30),
            DailyText.text("Pontuação: ${widget.results}").header.medium,
            const Gap(20),
            LinearProgressIndicator(
              value: widget.results / 40,
              color: getScoreColor(widget.results),
              backgroundColor: Colors.grey[200],
            ),
            const Gap(30),
            DailyText.text(getFeedbackMessage(widget.results, widget.testType)).body.large,
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Modular.to.navigate('/tests/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(158, 181, 103, 1),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Voltar para os testes",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
