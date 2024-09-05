import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../ui/daily_text.dart';

class GenderOnboardingPage extends StatefulWidget {
  const GenderOnboardingPage({super.key});

  @override
  State<GenderOnboardingPage> createState() => _GenderOnboardingPageState();
}

class _GenderOnboardingPageState extends State<GenderOnboardingPage> {
  bool isMale = false;
  bool isFemale = false;
  bool isPreferNotToSay = true;

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
                    value: 0.25,
                    color: const Color.fromRGBO(158, 181, 103, 1),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                DailyText.text('2/5').header.medium.bold,
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Qual seu gênero?",
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
                "Nos ajude a entender melhor você, selecionando seu gênero",
                style: TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFemale = false;
                          isPreferNotToSay = false;
                          isMale = true;
                        });
                      },
                      child: Container(
                        width: 124,
                        height: 124,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              isMale ? null : Border.all(color: Colors.black26),
                          color: isMale
                              ? Color.fromRGBO(158, 181, 103, 1)
                              : Colors.white,
                        ),
                        child: Icon(Icons.male,
                            size: 70,
                            color: isMale ? Colors.white : Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                     Text("Masculino",
                        style: TextStyle(
                            fontSize: 20,
                            color: isMale ? Color.fromRGBO(158, 181, 103, 1) : Colors.black))
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPreferNotToSay = false;
                          isMale = false;
                          isFemale = true;
                        });
                      },
                      child: Container(
                        width: 124,
                        height: 124,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                          isFemale ? null : Border.all(color: Colors.black26),
                          color: isFemale
                              ? Color.fromRGBO(158, 181, 103, 1)
                              : Colors.white,
                        ),
                        child: Icon(Icons.female,
                            size: 70,
                            color: isFemale ? Colors.white : Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                     Text("Feminino",
                        style: TextStyle(
                            fontSize: 20,
                            color: isFemale ? Color.fromRGBO(158, 181, 103, 1) : Colors.black))
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  isMale = false;
                  isFemale = false;
                  isPreferNotToSay = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 180,
                height: 49,
                decoration: BoxDecoration(
                    color: isPreferNotToSay ? const Color.fromRGBO(158, 181, 103, 1) : Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: isPreferNotToSay ? null : Border.all(color: Colors.black26)),
                child: isPreferNotToSay ? DailyText.text("Prefiro não dizer").body.large.bold.neutral : DailyText.text("Prefiro não dizer").body.large.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () {
                      if (isFemale) {
                        account!.gender = 0;
                      } else if (isMale) {
                        account!.gender = 1;
                      } else if (isPreferNotToSay) {
                        account!.gender = 2;
                      }

                      Modular.to.pushNamed('/onboarding/age');
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
