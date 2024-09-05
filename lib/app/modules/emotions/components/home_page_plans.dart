import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/domain/account.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../ui/daily_text.dart';

class HomePagePlans extends StatefulWidget {
  const HomePagePlans({super.key});

  @override
  State<HomePagePlans> createState() => _HomePagePlansState();
}

class _HomePagePlansState extends State<HomePagePlans> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Account? account = Provider.of<AccountProvider>(context, listen: true).account;

    const highlightColor = Color.fromRGBO(158, 181, 103, 1);

    Color getContainerColor(String keyword) {
      if (account?.completedGoals?.any((goal) => goal.contains(keyword)) ?? false) {
        return highlightColor;
      } else {
        return Colors.transparent;
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DailyText.text(
              "Planos para hoje (${(account?.completedGoals?.length ?? 0)}/3)"
          ).header.small.bold,

          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Dash(
                      direction: Axis.vertical,
                      length: 52,
                      dashLength: 20,
                      dashColor: Color.fromRGBO(158, 181, 103, 1)),
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: getContainerColor('meditar'),
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 1.5, color: highlightColor)),
                  ),
                  const Dash(
                      direction: Axis.vertical,
                      length: 100,
                      dashLength: 20,
                      dashColor: Color.fromRGBO(158, 181, 103, 1)),
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: getContainerColor('registro'),
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 1.5, color: highlightColor)),
                  ),
                  const Dash(
                      direction: Axis.vertical,
                      length: 100,
                      dashLength: 20,
                      dashColor: Color.fromRGBO(158, 181, 103, 1)),
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: getContainerColor('meta'),
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 1.5, color: highlightColor)),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Modular.to.navigate('/meditation');
                    },
                    child: Container(
                      width: 305,
                      height: 107,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Meditação", style: TextStyle(fontFamily: 'Pangram', fontSize: 15, color: Color.fromRGBO(158, 181, 103, 1))),
                                Text("Hora de meditar!", style: TextStyle(fontFamily: 'Pangram', fontSize: 19, fontWeight: FontWeight.bold)),
                                Text("5 min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
                              ],
                            ),
                            Image.asset("assets/article_illustration3.png")
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(25),
                  Container(
                    width: 305,
                    height: 107,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Registro", style: TextStyle(fontFamily: 'Pangram', fontSize: 15, color: Color.fromRGBO(158, 181, 103, 1))),
                              Text("Faça um registro diário!", style: TextStyle(fontFamily: 'Pangram', fontSize: 17.2, fontWeight: FontWeight.bold)),
                              Text("2 min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
                            ],
                          ),
                          Image.asset("assets/registro_concluido.png")
                        ],
                      ),
                    ),
                  ),
                  const Gap(25),
                  Container(
                    width: 305,
                    height: 107,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Planos", style: TextStyle(fontFamily: 'Pangram', fontSize: 15, color: Color.fromRGBO(158, 181, 103, 1))),
                              Text("Conclua um plano", style: TextStyle(fontFamily: 'Pangram', fontSize: 19, fontWeight: FontWeight.bold)),
                              Text("2-5 min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
                            ],
                          ),
                          Image.asset("assets/meta_concluida.png")
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
