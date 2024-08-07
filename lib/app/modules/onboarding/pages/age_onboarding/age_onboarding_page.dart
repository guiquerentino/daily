import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../ui/daily_text.dart';

class AgeOnboardingPage extends StatefulWidget {
  const AgeOnboardingPage({super.key});

  @override
  State<AgeOnboardingPage> createState() => _AgeOnboardingPageState();
}

class _AgeOnboardingPageState extends State<AgeOnboardingPage> {
  int _ageSelected = 18;

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
                    value: 0.6,
                    color: const Color.fromRGBO(158, 181, 103, 1),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                DailyText.text('3/5').header.medium.bold,
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Qual sua idade?",
              style: TextStyle(
                  fontFamily: 'Pangram',
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: Text(
                "Sua idade ajuda a melhorarmos nossas recomendações",
                style: TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 60),
            NumberPicker(
              value: _ageSelected,
              minValue: 0,
              maxValue: 100,
              textStyle: const TextStyle(fontSize: 30, fontFamily: 'Pangram'),
              itemCount: 8,
              selectedTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Color.fromRGBO(158, 181, 103, 1) ),
              onChanged: (value) => setState(() => _ageSelected = value),
            ),
            const Spacer(),
            SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () {
                      account!.age = _ageSelected;
                      Modular.to.pushNamed('/onboarding/objectives');
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
