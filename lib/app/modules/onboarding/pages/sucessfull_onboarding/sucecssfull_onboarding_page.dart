import 'dart:convert';

import 'package:daily/app/core/domain/external/onboarding_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';

class SucessfullOnboardingPage extends StatefulWidget {
  const SucessfullOnboardingPage({super.key});

  @override
  State<SucessfullOnboardingPage> createState() =>
      _SucessfullOnboardingPageState();
}

class _SucessfullOnboardingPageState extends State<SucessfullOnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animation.addListener(() {
      setState(() {});
    });

    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;
    if (account != null) {
      _doOnboarding(account);
    }
  }

  Future<void> _doOnboarding(Account account) async {
    OnboardingDTO request = OnboardingDTO(
        accountId: account.id!,
        fullName: account.fullName!,
        gender: account.gender!,
        age: account.age!,
        target: account.targets!,
        meditationExperience: account.meditationExperience!);

    final url = Uri.parse('http://10.0.2.2:8080/api/v1/user/onboarding?userId=' + request.accountId.toString());
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode(request.toJson());

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        Modular.to.pushNamed('/emotions');
      } else {
        print('Falha ao enviar OnboardingDTO: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao enviar OnboardingDTO: $e');
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              children: [
                Text(
                  "Preparando sua conta",
                  style: TextStyle(
                      fontFamily: 'Pangram',
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: Text(
                    "Aguarde um momento...",
                    style: TextStyle(
                        fontFamily: 'Pangram',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 6.0,
              animation: true,
              percent: 0.75,
              center: Text(
                '${_animation.value.toStringAsFixed(0)}%',
                style: const TextStyle(
                    fontFamily: 'Pangram',
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: const Color.fromRGBO(158, 181, 103, 1),
            ),
            const SizedBox(
              width: 250,
              child: Text(
                "Estamos preparando a melhor experiência para você.",
                style: TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
