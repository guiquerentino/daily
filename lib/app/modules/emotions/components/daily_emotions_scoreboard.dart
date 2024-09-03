import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DailyEmotionsScoreboard extends StatefulWidget {
  const DailyEmotionsScoreboard({super.key});

  @override
  State<DailyEmotionsScoreboard> createState() => _DailyEmotionsScoreboardState();
}

class _DailyEmotionsScoreboardState extends State<DailyEmotionsScoreboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 4.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DailyText.text("Área de desenvolvimento").header.small.bold,
            const Divider(),
            Container(
              alignment: Alignment.center,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 0,
                runSpacing: 0,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 50 / 100,
                        center: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '50\n',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color.fromRGBO(158, 181, 103, 1),
                        footer:  const Text(
                          "Mental",
                          style:
                           TextStyle(fontFamily: 'Pangram',fontWeight: FontWeight.w300, fontSize: 15.0),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 50 / 100,
                        center: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '50\n',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color.fromRGBO(158, 181, 103, 1),
                        footer:  const Text(
                          "Foco",
                          style:
                           TextStyle(fontFamily: 'Pangram',fontWeight: FontWeight.w300, fontSize: 15.0),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 50 / 100,
                        center: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '50\n',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color.fromRGBO(158, 181, 103, 1),
                        footer:  const Text(
                          "Relações",
                          style:
                           TextStyle(fontFamily: 'Pangram',fontWeight: FontWeight.w300, fontSize: 15.0),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 50 / 100,
                        center: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '50\n',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color.fromRGBO(158, 181, 103, 1),
                        footer: const Text(
                          "Finanças",
                          style:
                           TextStyle(fontFamily: 'Pangram',fontWeight: FontWeight.w300, fontSize: 15.0),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 50 / 100,
                        center: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '50\n',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color.fromRGBO(158, 181, 103, 1),
                        footer:  const Text(
                          "Auto-estima",
                          style:
                           TextStyle(fontFamily: 'Pangram',fontWeight: FontWeight.w300, fontSize: 15.0),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 50 / 100,
                        center: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '50\n',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color.fromRGBO(158, 181, 103, 1),
                        footer: const Text(
                          "Stress",
                          style:
                          TextStyle(fontFamily: 'Pangram',fontWeight: FontWeight.w300, fontSize: 15.0),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
