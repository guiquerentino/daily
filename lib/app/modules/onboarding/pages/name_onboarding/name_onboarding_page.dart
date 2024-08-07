import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../ui/daily_text.dart';

class NameOnboardingPage extends StatefulWidget {
  const NameOnboardingPage({super.key});

  @override
  State<NameOnboardingPage> createState() => _NameOnboardingPageState();
}

class _NameOnboardingPageState extends State<NameOnboardingPage> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 250,
                  height: 7,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    value: 0.2,
                    color: const Color.fromRGBO(158, 181, 103, 1),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                DailyText.text("1/5").header.medium.bold,
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Como devemos te chamar",
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
                "Vamos começar com o pé direito, qual seu nome?",
                style: TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: 300,
              height: 300,
              child: TextFormField(
                controller: nameController,
                minLines: 1,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Pangram',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Nome',
                  hintStyle: TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(229, 229, 229, 1.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(229, 229, 229, 1.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(229, 229, 229, 1.0)),
                  ),
                  fillColor: Color.fromRGBO(236, 236, 236, 1.0),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        account!.fullName = nameController.text;
                        Modular.to.pushNamed('/onboarding/gender');
                      }
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
