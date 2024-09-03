import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../../core/domain/providers/bottom_navigation_bar_provider.dart';
import '../../../emotions/components/daily_drawer.dart';
import '../../../ui/daily_app_bar.dart';
import '../../../ui/daily_bottom_navigation_bar.dart';

class HealthAreaPage extends StatefulWidget {
  const HealthAreaPage({super.key});

  @override
  State<HealthAreaPage> createState() => _HealthAreaPageState();
}

class _HealthAreaPageState extends State<HealthAreaPage> {
  final controllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Account? account = Provider.of<AccountProvider>(context).account;
    if (account != null && account.codeToConnect!.length == 6) {
      for (int i = 0; i < 6; i++) {
        controllers[i].text = account.codeToConnect![i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DailyDrawer(),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: DailyAppBar(title: "Área Saúde"),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(30, 8, 0, 0),
              alignment: Alignment.topLeft,
              child: const Text("Explorar", textAlign: TextAlign.start, style: TextStyle(fontSize: 16, fontFamily: 'Pangram', fontWeight: FontWeight.bold))),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            direction: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 1;
                  Modular.to.navigate('/meditation');
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/article_illustration3.png', height: 70, width: 70),
                      const Text("Meditação")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 1;
                  Modular.to.navigate('/goals');
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/article_illustration2.png', height: 70, width: 70),
                      const Text("Metas")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 1;
                  Modular.to.navigate('/articles');
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/article_illustration4.png', height: 70, width: 70),
                      const Text("Artigos")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 1;
                  Modular.to.navigate('/annotations');
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/article_illustration5.png', height: 70, width: 70),
                      const Text("Anotações")
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/article_illustration.png', height: 70, width: 70),
                    const Text("Afirmações")
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/article_illustration6.png', height: 70, width: 70),
                    const Text("Testes")
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 426.4,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DailyText.text("Código de conexão").header.small.bold,
                          const SizedBox(height: 5),
                          const Text("Utilize o seguinte código para conectar com seu médico", style: TextStyle(fontFamily: 'Pangram', fontSize: 18, fontWeight: FontWeight.w200), textAlign: TextAlign.center)
                        ],
                      )),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 3)
                            ],
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

        ],
      ),
    );
  }
}
