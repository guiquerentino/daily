import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../ui/daily_text.dart';

class MeditationExperienceOnboardingPage extends StatefulWidget {
  const MeditationExperienceOnboardingPage({super.key});

  @override
  State<MeditationExperienceOnboardingPage> createState() =>
      _MeditationExperienceOnboardingPageState();
}

class _MeditationExperienceOnboardingPageState
    extends State<MeditationExperienceOnboardingPage> {
  bool isRegularly = true;
  bool isOcasionally = false;
  bool isLongTimeAgo = false;
  bool isNever = false;

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
                    value: 1,
                    color: const Color.fromRGBO(158, 181, 103, 1),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                DailyText.text('5/5').header.medium.bold,
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Qual sua experiência com meditação?",
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
                "Você ja meditou, ou tentou técnicas mindfulness alguma vez?",
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
                      isRegularly = true;
                      isOcasionally = false;
                      isLongTimeAgo = false;
                      isNever = false;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isRegularly
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sim, regularmente",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isRegularly)
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
                      isRegularly = false;
                      isOcasionally = true;
                      isLongTimeAgo = false;
                      isNever = false;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isOcasionally
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sim, ocasionalmente",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isOcasionally)
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
                      isRegularly = false;
                      isOcasionally = false;
                      isLongTimeAgo = true;
                      isNever = false;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isLongTimeAgo
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sim, há muito tempo",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isLongTimeAgo)
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
                      isRegularly = false;
                      isOcasionally = false;
                      isLongTimeAgo = false;
                      isNever = true;
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: isNever
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Não, nunca pratiquei",
                            style: TextStyle(
                                fontFamily: 'Pangram',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        if (isNever)
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
                      if (isRegularly) {account!.meditationExperience = 0;}

                      if (isOcasionally) {account!.meditationExperience = 1;}

                      if (isLongTimeAgo) {account!.meditationExperience = 2;}

                      if (isNever) {account!.meditationExperience = 3;}

                      Modular.to.pushNamed('/onboarding/sucessfull');
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

/*

 */
