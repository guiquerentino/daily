import 'dart:io';

import 'package:daily/components/DailyBottomNavigationBar.dart';
import 'package:daily/components/DailyDrawer.dart';
import 'package:daily/entities/AccountRequest.dart';
import 'package:daily/http/RegistroHttp.dart';
import 'package:daily/utils/DateUtils.dart';
import 'package:daily/utils/EmojisUtils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../entities/Registro.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int dataSelecionadaIndex = 0;
  bool mostrarRegistros = true;
  DateTime dataSelecionada = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  bool _isLoading = true;
  List<Registro> registros = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
      _loadRegistros();
    });
  }

  Future<void> _loadRegistros() async {
    final params = ModalRoute.of(context)?.settings.arguments as AccountRequest;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Registro> loadedRegistros =
          await RegistroHttp().recuperarRegistros(params.id!, dataSelecionada);

      setState(() {
        loadedRegistros
            .sort((a, b) => b.dataHoraCriacao.compareTo(a.dataHoraCriacao));
        registros = loadedRegistros;
      });
      _isLoading = false;
    } catch (e) {
      print('Erro ao carregar registros: $e');
    }
  }

  DateTime _getDateWithMidnight(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
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
        dataSelecionada = DateTime(picked.year, picked.month, picked.day);
        dataSelecionadaIndex = -1;
      });
      _loadRegistros();
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
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
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
                                  dataSelecionada = _getDateWithMidnight(
                                      DateTime.now()
                                          .subtract(Duration(days: i)));
                                  _loadRegistros();
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
                    const Text(
                      "Seus registros",
                      style: TextStyle(fontSize: 14, fontFamily: 'Pangram'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (mostrarRegistros == false) {
                            _loadRegistros();
                          }
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
                          if (registros.isEmpty && _isLoading == false)
                            Center(
                              child: Column(
                                children: [
                                  const Gap(10),
                                  Image.asset("assets/emoji_not_found.png"),
                                  const Gap(25),
                                  const Text(
                                    "Nenhum registro encontrado.",
                                    style: TextStyle(
                                        fontFamily: 'Pangram', fontSize: 20),
                                  )
                                ],
                              ),
                            )
                          else if (_isLoading == false)
                            for (int i = 0; i < registros.length; i++)
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                                  child: Container(
                                    width: double.maxFinite,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18.0)),
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
                                                  registros[i].emotionType),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        EmojisUtils()
                                                            .retornaNomeFormatadoEmocao(
                                                                registros[i]
                                                                    .emotionType),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Pangram')),
                                                    Text(
                                                        DateFormat()
                                                            .add_Hm()
                                                            .format(registros[i]
                                                                .dataHoraCriacao),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pangram',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  EmojisUtils()
                                                      .retornaEmojiClima(
                                                          registros[i]
                                                              .weatherType),
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
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontFamily: 'Pangram',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          const TextSpan(
                                                              text:
                                                                  'Motivos: '),
                                                          if (registros[i]
                                                                      .tags !=
                                                                  null &&
                                                              registros[i]
                                                                  .tags!
                                                                  .isNotEmpty)
                                                            ...registros[i]
                                                                .tags!
                                                                .map((tag) =>
                                                                    TextSpan(
                                                                      text:
                                                                          '$tag${registros[i].tags!.last != tag ? ', ' : ''}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ))
                                                                .toList(),
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                              text: registros[i]
                                                                  .text,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Pangram')),
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
                  ),
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
