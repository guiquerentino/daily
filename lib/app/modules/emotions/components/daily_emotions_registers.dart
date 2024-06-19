import 'package:daily/app/core/domain/providers/calendar_date_provider.dart';
import 'package:daily/app/core/utils/emoji_utils.dart';
import 'package:daily/app/modules/emotions/http/emotions_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/domain/account.dart';
import '../../../core/domain/emotion.dart';
import '../../../core/domain/providers/account_provider.dart';

class DailyEmotionRegisters extends StatefulWidget {
  const DailyEmotionRegisters({super.key});

  @override
  State<DailyEmotionRegisters> createState() => _DailyEmotionRegistersState();
}

class _DailyEmotionRegistersState extends State<DailyEmotionRegisters> {
  bool mostrarRegistros = true;
  List<Emotion> emotionList = [];
  late bool isLoading;

  Future<void> fetchEmotions() async {
    Account? account =
        Provider.of<AccountProvider>(context, listen: true).account;

    DateTime selectedDate =
        Provider.of<CalendarDateProvider>(context, listen: true).selectedDate;

    isLoading = true;

    List<Emotion> fetchedEmotions =
        await EmotionsHttp().fetchRegister(account?.id, selectedDate);

    isLoading = false;
    setState(() {
      emotionList = fetchedEmotions;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchEmotions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Seus registros',
              style: TextStyle(fontSize: 14, fontFamily: 'Pangram'),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  mostrarRegistros = !mostrarRegistros;
                });
              },
              child: Icon(
                mostrarRegistros
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                size: 20,
              ),
            )
          ],
        ),
        const Gap(20),
        if (mostrarRegistros)
          AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: -10.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: emotionList.map((emotion) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 4.0),
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EmojisUtils().retornaEmojiEmocao(emotion.emotionType!, false),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          EmojisUtils
                                              .retornaNomeFormatadoEmocao(
                                                  emotion.emotionType!),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Pangram',
                                          ),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_Hm()
                                              .format(emotion.creationDate!),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert),
                                    padding: const EdgeInsets.only(
                                      top: 0,
                                      bottom: 10,
                                      right: 0,
                                      left: 20,
                                    ),
                                  ),
                                ],
                              ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    runSpacing: 2,
                                    spacing: 6,
                                    direction: Axis.horizontal,
                                    children: emotion.tags!
                                        .map(
                                          (tag) => Container(
                                        constraints: const BoxConstraints(maxWidth: 160),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                130, 130, 130, 1.0)
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(tag.emote),
                                            const SizedBox(width: 2),
                                            Text(
                                              tag.text,
                                              style: const TextStyle(
                                                fontFamily: 'Pangram',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                  const SizedBox(height: 8.0),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontFamily: 'Pangram',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: 'Nota: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: emotion.text,
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
