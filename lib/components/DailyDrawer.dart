import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DailyDrawer extends StatelessWidget {
  final String? accountName;
  final String? accountEmail;

  const DailyDrawer(
      {super.key, required this.accountName, required this.accountEmail});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(5, 16, 141, 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(30)),
                            ),
                            child: SvgPicture.asset('assets/emoji_angel.svg')),
                        const Gap(15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(" ${accountName ?? " usuário"}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                            Text(" ${accountEmail ?? "email"}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text("Calendário"),
                  onTap: () {
                  },
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.emoji_events),
                  title: const Text("Conquistas"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.newspaper),
                  title: const Text("Artigos"),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.watch),
                  title: const Text("Lembretes"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.psychology),
                  title: const Text("Espaço Saúde"),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Configurações"),
                  onTap: () {},
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text("Sair"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
