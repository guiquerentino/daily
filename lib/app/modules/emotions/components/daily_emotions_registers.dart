import 'package:daily/app/core/domain/providers/calendar_date_provider.dart';
import 'package:daily/app/core/utils/emoji_utils.dart';
import 'package:daily/app/modules/emotions/components/daily_edit_page_view.dart';
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

  Future<void> fetchEmotions(DateTime selectedDate) async {
    Account? account = Provider.of<AccountProvider>(context, listen: false).account;

    if (account == null) return;

    List<Emotion> fetchedEmotions = await EmotionsHttp().fetchRegister(account.id, selectedDate);
    fetchedEmotions.sort((a, b) => b.creationDate!.compareTo(a.creationDate!));

    setState(() {
      emotionList = fetchedEmotions;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedDate = Provider.of<CalendarDateProvider>(context, listen: false).selectedDate;
    fetchEmotions(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CalendarDateProvider, DateTime>(
      selector: (_, provider) => provider.selectedDate,
      builder: (_, selectedDate, __) {
        fetchEmotions(selectedDate);
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
              emotionList.isNotEmpty
                  ? AnimationLimiter(
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(18.0)),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      EmojisUtils().retornaEmojiEmocao(
                                          emotion.emotionType!, false),
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
                                                  .format(
                                                  emotion.creationDate!),
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
                                      PopupMenuButton<String>(
                                        padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 10,
                                          right: 0,
                                          left: 20,
                                        ),
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (BuildContext context) {
                                                  return DailyEditPageView(emotion: emotion);
                                                }
                                            );
                                          } else if (value == 'delete') {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                    const Text('Atenção!'),
                                                    content:
                                                    const SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Você deseja excluir esse registro?'),
                                                          Text(
                                                              'Esses dados serão perdidos para sempre.'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                          'Cancelar',
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Pangram',
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                              context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            'Excluir',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Pangram',
                                                                color: Colors
                                                                    .red)),
                                                        onPressed: () async {
                                                          await EmotionsHttp()
                                                              .deleteRegister(
                                                              emotion
                                                                  .id!);
                                                          await fetchEmotions(selectedDate);
                                                          if (mounted) {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return [
                                            const PopupMenuItem(
                                              value: 'edit',
                                              child: Text('Editar'),
                                            ),
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Excluir'),
                                            ),
                                          ];
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (emotion.tags != null &&
                                              emotion.tags!.isNotEmpty)
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
                                                    text: 'Motivos: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: emotion.tags!
                                                        .map((tag) => tag.text)
                                                        .join(', '),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (emotion.text != '') ...[
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
                                                    text: 'Notas: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: emotion.text,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
              )
                  : Column(
                children: [
                  Image.asset('assets/emoji_not_found.png'),
                  const Gap(10),
                  const Text(
                    'Nenhum registro encontrado',
                    style: TextStyle(fontSize: 16, fontFamily: 'Pangram'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
