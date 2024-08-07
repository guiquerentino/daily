import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../ui/daily_text.dart';

class ObjectivesOnboardingPage extends StatefulWidget {
  const ObjectivesOnboardingPage({super.key});

  @override
  State<ObjectivesOnboardingPage> createState() =>
      _ObjectivesOnboardingPageState();
}

class _ObjectivesOnboardingPageState
    extends State<ObjectivesOnboardingPage> {
  bool isControlAnxiety = true;
  bool isReduceStress = false;
  bool isImproveMood = false;
  bool isImproveSleep = false;
  bool isImproveConfidence = false;
  bool isImproveFocus = false;

  @override
  Widget build(BuildContext context) {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Modular.to.pop();
                    },
                    child: const Icon(Icons.arrow_back, size: 35)),
                SizedBox(
                  width: 250,
                  height: 7,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    value: 0.8,
                    color: const Color.fromRGBO(158, 181, 103, 1),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                DailyText.text('4/5').header.medium.bold,
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Quais são seus objetivos?",
              style: TextStyle(
                  fontFamily: 'Pangram',
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 350,
              child: Text(
                "Selecione abaixo as opções que melhor representam o que você almeja alcançar.",
                style: TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isControlAnxiety = !isControlAnxiety;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                          color: isControlAnxiety
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Controlar Ansiedade",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isControlAnxiety)
                          const Icon(Icons.check,
                              color: Color.fromRGBO(158, 181, 103, 1))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isReduceStress = !isReduceStress;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isReduceStress
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Reduzir Estresse",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isReduceStress)
                          const Icon(Icons.check,
                              color: Color.fromRGBO(158, 181, 103, 1))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isImproveMood = !isImproveMood;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isImproveMood
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Melhorar Humor",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isImproveMood)
                          const Icon(Icons.check,
                              color: Color.fromRGBO(158, 181, 103, 1))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isImproveSleep = !isImproveSleep;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isImproveSleep
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Melhorar Sono",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isImproveSleep)
                          const Icon(Icons.check,
                              color: Color.fromRGBO(158, 181, 103, 1))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isImproveConfidence = !isImproveConfidence;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isImproveConfidence
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Aumentar Confiança",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isImproveConfidence)
                          const Icon(Icons.check,
                              color: Color.fromRGBO(158, 181, 103, 1))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isImproveFocus = !isImproveFocus;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isImproveFocus
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Melhorar Foco",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isImproveFocus)
                          const Icon(Icons.check,
                              color: Color.fromRGBO(158, 181, 103, 1))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () {
                      List<int> selectedTargets = [];
                      if (isControlAnxiety) selectedTargets.add(0);
                      if (isReduceStress) selectedTargets.add(1);
                      if (isImproveMood) selectedTargets.add(2);
                      if (isImproveSleep) selectedTargets.add(3);
                      if (isImproveConfidence) selectedTargets.add(4);
                      if (isImproveFocus) selectedTargets.add(5);

                      account!.targets = selectedTargets;

                      Modular.to.pushNamed('/onboarding/meditation-experience');
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(158, 181, 103, 1))),
                    child: const Text("Continuar",
                        style: TextStyle(fontSize: 18, fontFamily: 'Pangram'))))
          ],
        ),
      ),
    );
  }
}
