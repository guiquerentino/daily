import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/account.dart';
import '../../../../core/domain/providers/account_provider.dart';
import '../../../../core/domain/providers/bottom_navigation_bar_provider.dart';
import '../../../emotions/components/daily_drawer.dart';
import '../../../ui/daily_app_bar.dart';
import '../../../ui/daily_bottom_navigation_bar.dart';
import '../../../ui/daily_text.dart';

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
            child: const Text("Explorar", textAlign: TextAlign.start, style: TextStyle(fontSize: 16, fontFamily: 'Pangram', fontWeight: FontWeight.bold)),
          ),
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
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      int currentIndex = 0;
                      List<Map<String, String>> affirmations = [
                        {
                          "quote":
                          "Só há felicidade se não exigirmos nada do amanhã e aceitarmos do hoje, com gratidão, o que nos trouxer. A hora mágica chega sempre.",
                          "author": "Hermann Hesse"
                        },
                        {
                          "quote":
                          "Quando seu coração está pleno de gratidão, qualquer porta aparentemente fechada pode ser uma abertura para uma bênção maior.",
                          "author": "Osho"
                        },
                        {
                          "quote":
                          "Sucesso é um esporte coletivo. Demonstre gratidão a todos os que colaboram com suas vitórias.",
                          "author": "Carlos Hilsdorf"
                        },
                        {
                          "quote":
                          "Desconfie do destino e acredite em você. Gaste mais horas realizando que sonhando, fazendo que planejando, embora quem quase morre esteja vivo, quem quase vive já morreu.",
                          "author": "Abidurai Naxumerus"
                        },
                        {
                          "quote":
                          "Quando você conhece a sensação de fracasso, a determinação persegue o sucesso.",
                          "author": "Kobe Bryant"
                        },
                        {
                          "quote":
                          "Acredite que você pode e você já está no meio do caminho.",
                          "author": "Theodore Roosevelt"
                        },
                        {
                          "quote":
                          "A única maneira de fazer um ótimo trabalho é amar o que você faz.",
                          "author": "Steve Jobs"
                        },
                        {
                          "quote":
                          "A vida é 10% o que acontece com você e 90% como você reage a isso.",
                          "author": "Charles R. Swindoll"
                        },
                        {
                          "quote":
                          "O mais importante é tentar inspirar as pessoas para que elas sejam excelentes no que querem fazer.",
                          "author": "Kobe Bryant"
                        },
                        {
                          "quote":
                          "Passo a passo. Não consigo pensar em nenhum outro modo de se realizar algo.",
                          "author": "Michael Jordan"
                        },
                      ];

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Icon(Icons.close, size: 32)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 16, right: 16),
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text:
                                                    '${affirmations[currentIndex]["quote"]}\n\n'),
                                            TextSpan(
                                              text:
                                                  '${affirmations[currentIndex]["author"]}',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: currentIndex > 0
                                              ? () {
                                                  setState(() {
                                                    currentIndex--;
                                                  });
                                                }
                                              : null,
                                          child: const Text("Anterior"),
                                        ),
                                        ElevatedButton(
                                          onPressed: currentIndex <
                                                  affirmations.length - 1
                                              ? () {
                                                  setState(() {
                                                    currentIndex++;
                                                  });
                                                }
                                              : null,
                                          child: const Text("Próximo"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
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
                      Image.asset('assets/article_illustration.png', height: 70, width: 70),
                      const Text("Afirmações")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 1;
                  Modular.to.navigate('/tests');
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
                      Image.asset('assets/article_illustration6.png', height: 70, width: 70),
                      const Text("Testes")
                    ],
                  ),
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
                        const Text(
                          "Utilize o seguinte código para conectar com seu médico",
                          style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 18,
                              fontWeight: FontWeight.w200
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
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
                                  blurRadius: 3
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
