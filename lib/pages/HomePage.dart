import 'package:daily/components/DailyBottomNavigationBar.dart';
import 'package:daily/components/DailyDrawer.dart';
import 'package:daily/entities/AccountRequest.dart';
import 'package:daily/utils/DateUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int dataSelecionadaIndex = 0;
  bool mostrarRegistros = true;
  DateTime dataSelecionada = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  void _scrollToEnd() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return "${text.substring(0, maxLength - 3)}...";
    }
    return text;
  }

  String formatDate(DateTime date) {
    return DateFormat('E, d MMM', 'pt_BR').format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dataSelecionada) {
      setState(() {
        dataSelecionada = picked;
        dataSelecionadaIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments as AccountRequest;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            size: 32,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              Text(formatDate(dataSelecionada),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Pangram')),
                              const Gap(5),
                              const Icon(
                                Icons.calendar_month,
                                color: Color.fromRGBO(127, 60, 211, 1),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                const Gap(10),
                RichText(
                  text: TextSpan(
                    text: "Olá,",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Pangram'),
                    children: <TextSpan>[
                      TextSpan(
                        text: (mediaQuery.size.width < 400)
                            ? truncateText(params.fullName!, 19)
                            : " ${params.fullName ?? " usuário"}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pangram',
                            overflow: TextOverflow.ellipsis),
                      ),
                      const TextSpan(
                        text: " 👋",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 80,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 20; i >= 0; i--)
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  dataSelecionadaIndex = i;
                                  dataSelecionada = DateTime.now()
                                      .subtract(Duration(days: i));
                                });
                              },
                              child: Container(
                                height: 68,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: (dataSelecionadaIndex == i)
                                      ? const Color.fromRGBO(139, 76, 252, 1)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 4.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        DataUtils.formatDate(DateFormat()
                                            .add_EEEE()
                                            .format(DateTime.now()
                                                .subtract(Duration(days: i)))),
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                            fontFamily: 'Pangram',
                                            color: (dataSelecionadaIndex == i)
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                        DateFormat().add_d().format(
                                            DateTime.now()
                                                .subtract(Duration(days: i))),
                                        style: TextStyle(
                                            color: (dataSelecionadaIndex == i)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (mediaQuery.size.width < 400)
                          ? "Seus registros"
                          : "Abaixo estão os seus registros de emoções do dia.",
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
                        children: [
                          for (int i = 0; i <= 6; i++)
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
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
                                            Image.asset("assets/emoji.png"),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Felicidade",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Pangram')),
                                                  Text("20:10",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Pangram',
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Image.asset("assets/sun.png"),
                                                const Gap(8),
                                                const Text("Editar",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontFamily: 'Pangram',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            )
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
                                                SizedBox(
                                                  width: 300.0,
                                                  child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: const TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Pangram',
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: 'Motivos: '),
                                                        TextSpan(
                                                          text: 'Trabalho',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(text: ', '),
                                                        TextSpan(
                                                          text: 'Família',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                // Adding some spacing
                                                SizedBox(
                                                  width: double.maxFinite,
                                                  child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: const TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Pangram',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Nota: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'Hoje eu finalmente recebi um aumento no trabalho, consegui pedir ao meu chefe. Depois que fui para casa joguei videogame com meu f..',
                                                        ),
                                                      ],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
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
                            ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        drawer: DailyDrawer(
          accountName: params.fullName,
          accountEmail: params.email,
        ),
        bottomNavigationBar: const DailyBottomNavigationBar());
  }
}
