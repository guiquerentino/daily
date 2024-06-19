import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/providers/calendar_date_provider.dart';
import '../../../core/utils/date_utils.dart';

class DailyEmotionsCalendar extends StatefulWidget {
  const DailyEmotionsCalendar({super.key});

  @override
  State<DailyEmotionsCalendar> createState() => _DailyEmotionsCalendarState();
}

class _DailyEmotionsCalendarState extends State<DailyEmotionsCalendar> {
  final ScrollController _scrollController = ScrollController();
  DateTime dataSelecionada = DateTime.now();
  DateTime dataAtual = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _scrollToToday() {
    int diaAtual = dataAtual.day;
    double offset = (diaAtual - 1) * 58.0;
    _scrollController.jumpTo(offset);
  }

  void _incrementMonth() {
    setState(() {
      dataAtual = DateTime(dataAtual.year, dataAtual.month + 1, 1);
    });
  }

  void _decrementMonth() {
    setState(() {
      dataAtual = DateTime(dataAtual.year, dataAtual.month - 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    String mesAnoAtual = toBeginningOfSentenceCase(
            DateFormat.yMMMM('pt_BR').format(dataAtual)) ??
        '';
    int ultimoDiaDoMes =
        DateUtils.getDaysInMonth(dataAtual.year, dataAtual.month);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: _decrementMonth,
                icon: Icon(Icons.arrow_back_ios_new, size: 18)),
            Text(mesAnoAtual,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pangram',
                    fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: _incrementMonth,
                icon: Icon(Icons.arrow_forward_ios, size: 18)),
          ],
        ),
        SizedBox(
          width: double.maxFinite,
          height: 80,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 1; i <= ultimoDiaDoMes; i++)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 9.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          dataSelecionada =
                              DateTime(dataAtual.year, dataAtual.month, i);
                          final selectedDateProvider =
                              Provider.of<CalendarDateProvider>(context,
                                  listen: false);
                          selectedDateProvider.selectedDate =
                              DateTime(dataAtual.year, dataAtual.month, i);
                        });
                      },
                      child: Container(
                        height: 68,
                        width: 50,
                        decoration: BoxDecoration(
                          color: (dataSelecionada.day == i &&
                                  dataSelecionada.month == dataAtual.month)
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
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
                                    .format(DateTime(
                                        dataAtual.year, dataAtual.month, i))),
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontFamily: 'Pangram',
                                    color: (dataSelecionada.day == i &&
                                            dataSelecionada.month ==
                                                dataAtual.month)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w400)),
                            Text(
                                DateFormat().add_d().format(DateTime(
                                    dataAtual.year, dataAtual.month, i)),
                                style: TextStyle(
                                    color: (dataSelecionada.day == i &&
                                            dataSelecionada.month ==
                                                dataAtual.month)
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
      ],
    );
  }
}

class DateUtils {
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
