import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../core/domain/account.dart';
import '../../../core/domain/external/annotation_request.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';

class AnnotationsPage extends StatefulWidget {
  const AnnotationsPage({super.key});

  @override
  State<AnnotationsPage> createState() => _AnnotationsPageState();
}

class _AnnotationsPageState extends State<AnnotationsPage> {
  List<AnnotationRequest> annotations = [];

  @override
  void initState() {
    super.initState();
    fetchAnnotations();
    initializeDateFormatting('pt_BR', null);
  }

  Future<void> fetchAnnotations() async {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;

    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/annotations?authorId=${account?.id}'));
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> annotationsJson = json.decode(response.body);
        setState(() {
          annotations = annotationsJson
              .map((json) => AnnotationRequest.fromJson(json))
              .toList();
          annotations.sort((a, b) => b.creationDate.compareTo(a.creationDate));
        });
      } else {
        throw Exception('Falha ao carregar anotações');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _showDeleteConfirmationDialog(AnnotationRequest annotation) async {
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
                    'http://10.0.2.2:8080/api/v1/annotations?id=${annotation.id}'));
                setState(() {
                  annotations.remove(annotation);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAnnotationDialog(BuildContext context) async {
    final TextEditingController textController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Nota'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Digite sua nota aqui'),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                String noteText = textController.text;
                if (noteText.isNotEmpty) {
                  Account? account =
                      Provider.of<AccountProvider>(context, listen: false).account;

                  AnnotationRequest request = AnnotationRequest(
                    authorId: account?.id ?? 0,
                    text: noteText,
                    creationDate: DateTime.now(),
                  );

                  setState(() {
                    annotations.add(request);
                    annotations.sort((a, b) => a.creationDate.compareTo(b.creationDate));
                  });

                  http.post(
                    Uri.parse('http://10.0.2.2:8080/api/v1/annotations'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(request.toJson()),
                  );

                  Navigator.of(context).pop();
                }
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
                    DailyText.text("Anotações").header.medium.bold,
                    IconButton(
                      onPressed: () {
                        showAnnotationDialog(context);
                      },
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
          (annotations.isNotEmpty)
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              runSpacing: 12,
              children: annotations.map((annotation) {
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
                            Text(annotation.text,
                                style: const TextStyle(
                                    color:
                                    Color.fromRGBO(158, 181, 103, 1),
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Pangram')),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    DateFormat('dd/MM/yy HH:mm')
                                        .format(annotation.creationDate),
                                    style: TextStyle(
                                        fontFamily: 'Pangram',
                                        fontWeight: FontWeight.w400)),
                                GestureDetector(
                                    onTap: () {
                                      _showDeleteConfirmationDialog(annotation);
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
                'Nenhuma anotação encontrada',
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
