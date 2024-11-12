import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../../core/domain/account.dart';
import '../../../core/domain/goal.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';
import 'package:http/http.dart' as http;

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}


class _GoalsPageState extends State<GoalsPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  List<Goal> fetchedGoals = [];
  Map<int, bool> isExpanded = {};

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    initializeNotifications();
    fetchAllGoals();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> toggleGoalDoneStatus(Goal request) async {

    request.isDone = !request.isDone;

    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8080/api/v1/goals'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(request.toJson())
      );

      if (response.statusCode == 200) {
        setState(() {
          fetchedGoals = fetchedGoals.map((goal) {
            if (goal.id == request.id) {
              return goal.copyWith(isDone: goal.isDone);
            }
            return goal;
          }).toList();
        });
      } else {
        throw Exception('Falha ao atualizar o estado da meta');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  Future<void> scheduleNotification(Goal goal) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
     AndroidNotificationDetails(
      'goals_notification',
      'goals_name',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(goal.scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      goal.id!,
      'Meta: ${goal.title}',
      'Está na hora de realizar sua meta!',
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> fetchAllGoals() async {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;

    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8080/api/v1/goals?userId=${account?.id}'));
      if (response.statusCode == 200) {
        final List<dynamic> goalsJson = json.decode(response.body);
        setState(() {
          fetchedGoals = goalsJson.map((json) => Goal.fromJson(json)).toList();
          fetchedGoals.sort((a, b) => b.creationDate!.compareTo(a.creationDate!));
        });
      } else {
        throw Exception('Falha ao carregar metas');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _showDeleteConfirmationDialog(int goalId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você realmente deseja excluir esta anotação?'),
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
                    'http://10.0.2.2:8080/api/v1/goals?goalId=${goalId}'));
                setState(() {
                  fetchedGoals.removeWhere((goal) => goal.id == goalId);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddReminderDialog() async {
    String? goalText;
    DateTime? goalDateTime;
    bool isAllDay = false;
    bool isAllDayButtonPressed = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Adicionar Meta'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nome da Meta',
                    ),
                    onChanged: (value) {
                      goalText = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: isAllDayButtonPressed
                            ? null
                            : () async {
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
                                goalDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                isAllDay = false;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          goalDateTime != null
                              ? "${goalDateTime!.day}/${goalDateTime!.month}/${goalDateTime!.year} ${goalDateTime!.hour}:${goalDateTime!.minute}"
                              : 'Defina uma data',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isAllDayButtonPressed = !isAllDayButtonPressed;
                            isAllDay = isAllDayButtonPressed;
                            goalDateTime = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAllDayButtonPressed
                              ? const Color.fromRGBO(158, 181, 103, 1)
                              : Colors.white,
                        ),
                        child: Text(
                          'Todos os dias',
                          style: TextStyle(
                            color: isAllDayButtonPressed ? Colors.white : Colors.black,
                          ),
                        ),
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
                    if (goalText != null) {
                      Account? account =
                          Provider.of<AccountProvider>(context, listen: false)
                              .account;

                      final goal = Goal(
                        title: goalText!,
                        isDone: false,
                        createdBy: account!.fullName!,
                        scheduledTime: isAllDay ? DateTime.now() : goalDateTime!,
                        userId: account!.id!,
                        isAllDay: isAllDay,
                      );

                      try {
                        final response = await http.post(
                          Uri.parse('http://10.0.2.2:8080/api/v1/goals'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(goal.toJson()),
                        );

                        if (response.statusCode == 201) {
                          final newGoal = Goal.fromJson(jsonDecode(response.body));

                          setState(() {
                            fetchedGoals.add(newGoal);
                          });

                          scheduleNotification(newGoal);

                          fetchAllGoals();
                        } else {
                          throw Exception('Falha ao adicionar a meta');
                        }
                      } catch (e) {
                        print(e.toString());
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
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      drawer: const DailyDrawer(),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(children: [
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
                    DailyText.text("Metas").header.medium.bold,
                    IconButton(
                      onPressed: () {
                        _showAddReminderDialog();
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                (fetchedGoals.isNotEmpty)
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    runSpacing: 12,
                    children: fetchedGoals.map((goal) {
                      bool expanded = isExpanded[goal.id] ?? false;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded[goal.id!] = !expanded;
                              });
                            },
                            child: Container(
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _decodeUtf8(goal.title),
                                          style: TextStyle(
                                            color: const Color.fromRGBO(158, 181, 103, 1),
                                            fontSize: 18,
                                            fontFamily: 'Pangram',
                                            decoration: goal.isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          onSelected: (String value) {
                                            if (value == 'markComplete') {
                                              toggleGoalDoneStatus(goal);
                                            } else if (value == 'delete') {
                                              _showDeleteConfirmationDialog(goal.id!);
                                            }
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem<String>(
                                                value: 'markComplete',
                                                child: Text(goal.isDone ? 'Desmarcar como concluído' : 'Marcar como concluído'),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'delete',
                                                child: Text('Excluir'),
                                              ),
                                            ];
                                          },
                                          icon: const Icon(Icons.more_vert, size: 24),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          goal.isAllDay
                                              ? 'Todos os dias'
                                              : DateFormat('dd/MM/yy HH:mm').format(goal.scheduledTime),
                                          style: const TextStyle(
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (expanded)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "Criado por: ${goal.createdBy}",
                                          style: const TextStyle(
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
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
                      'Nenhuma meta encontrada',
                      style: TextStyle(fontSize: 16, fontFamily: 'Pangram'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

}
