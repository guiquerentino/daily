import 'package:daily/app/modules/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SucessfullAccountCreatedPage extends StatelessWidget {
  final String ROUTE_NAME = '/sucess-account';

  const SucessfullAccountCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/sucess.svg'),
            const Gap(15),
            const Text(
              "Parabéns!",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const Text(
              "Conta criada com sucesso!",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.navigate('/auth${const LoginPage().ROUTE_NAME}');
          },
          backgroundColor: Colors.black,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_forward, color: Colors.white)),
    );
  }
}
