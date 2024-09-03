import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../../core/domain/account.dart';
import '../../../core/domain/external/reminder_request.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<ReminderRequest> reminders = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    fetchReminders();
    tz.initializeTimeZones();
    initializeNotifications();
    initializeDateFormatting('pt_BR', null);
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(ReminderRequest reminder) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'reminder_notification',
      'reminder_name',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(reminder.scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.id!,
      'Lembrete acionado',
      '${reminder.text}',
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> fetchReminders() async {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8080/api/v1/reminder?userId=${account!.id}'));
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> reminderJson = json.decode(response.body);
        setState(() {
          reminders = reminderJson
              .map((json) => ReminderRequest.fromJson(json))
              .toList();
        });
      } else {
        throw Exception('Falha ao carregar lembretes');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _showAddReminderDialog() async {
    String? reminderText;
    DateTime? reminderDateTime;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Lembrete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome do Lembrete',
                ),
                onChanged: (value) {
                  reminderText = value;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Data e Horário:'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          setState(() {
                            reminderDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text(reminderDateTime != null
                        ? "${reminderDateTime!.day}/${reminderDateTime!.month}/${reminderDateTime!.year} ${reminderDateTime!.hour}:${reminderDateTime!.minute}"
                        : 'Defina uma data'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (reminderText != null && reminderDateTime != null) {
                  final newReminder = ReminderRequest(
                    text: reminderText!,
                    scheduledTime: reminderDateTime!,
                    isActivated: true,
                  );

                  Account? account =
                      Provider.of<AccountProvider>(context, listen: false)
                          .account;

                 final response = await http.post(
                      Uri.parse(
                          'http://10.0.2.2:8080/api/v1/reminder?userId=${account!.id}'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(newReminder.toJson()));

                 if(response.statusCode == 201 || response.statusCode == 200){
                   final newReminder = ReminderRequest.fromJson(jsonDecode(response.body));

                   setState(() {
                     reminders.add(newReminder);
                   });

                   scheduleNotification(newReminder);
                 }

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(ReminderRequest reminder) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você realmente deseja excluir este lembrete?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                await http.delete(Uri.parse(
                    'http://10.0.2.2:8080/api/v1/reminder?id=${reminder.id}'));
                setState(() {
                  reminders.remove(reminder);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DailyDrawer(),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu_outlined,
                            size: 30,
                          ),
                        );
                      },
                    ),
                    DailyText.text("Lembretes").header.medium.bold,
                    IconButton(
                      onPressed: _showAddReminderDialog,
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          (reminders.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    runSpacing: 12,
                    children: reminders.map((reminder) {
                      return Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(reminder.text,
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(158, 181, 103, 1),
                                          fontSize: 18,
                                          fontFamily: 'Pangram')),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          DateFormat('dd/MM/yy HH:mm')
                                              .format(reminder.scheduledTime),
                                          style: TextStyle(
                                              fontFamily: 'Pangram',
                                              fontWeight: FontWeight.w400)),
                                      GestureDetector(
                                          onTap: () {
                                            _showDeleteConfirmationDialog(
                                                reminder);
                                          },
                                          child: Icon(Icons.delete))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(60),
                    Image.asset('assets/emoji_not_found.png'),
                    const Gap(30),
                    const Text(
                      'Nenhum lembrete encontrado',
                      style: TextStyle(fontSize: 16, fontFamily: 'Pangram'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
