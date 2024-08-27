import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/account.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../../core/domain/providers/bottom_navigation_bar_provider.dart';
import '../../auth/pages/login_page.dart';

class DailyDrawer extends StatelessWidget {
  const DailyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Account? account = Provider.of<AccountProvider>(context).account;
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(

      backgroundColor: Colors.white,
      width: screenWidth * 0.85,
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
                            color: Color.fromRGBO(158, 181, 103, 1),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        const Gap(15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(account != null ? account.fullName! : 'Usuário',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                            Text(account != null ? account.email : 'email@email.com',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.psychology_alt_outlined),
                  title: DailyText.text("Espaço Saúde").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 1;
                    Modular.to.navigate('/health');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: DailyText.text("Calendário").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 2;
                    Modular.to.navigate('/emotions/history');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.note_outlined),
                  title: DailyText.text("Anotações").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 0;
                    Modular.to.navigate('/annotations');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.watch_outlined),
                  title: DailyText.text("Lembretes").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 0;
                    Modular.to.navigate('/reminders');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.newspaper_outlined),
                  title: DailyText.text("Artigos").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 0;
                    Modular.to.navigate('/articles');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.accessibility_new_sharp),
                  title: DailyText.text("Meditação").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Provider.of<BottomNavigationBarProvider>(context, listen: false).selectedIndex = 2;
                    Modular.to.navigate('/meditation');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: DailyText.text("Preferências").body.large.bold,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.red,
            ),
            title: const Text(
              "Sair",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();

              prefs.remove("email");
              prefs.remove("password");

              Modular.to.navigate("/auth${LoginPage().ROUTE_NAME}");
              Provider.of<AccountProvider>(context, listen: false).clearAccount();

            },
          ),
          Container(
            width: double.maxFinite,
            height: 84,
            color: const Color.fromRGBO(158, 181, 103, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(10),
                Container(
                  height: 47,
                  width: 47,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: const Icon(
                    Icons.lightbulb,
                    color: Color.fromRGBO(255, 152, 31, 1),
                  ),
                ),
                const Gap(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DailyText.text("Adquira a versão Premium")
                        .body
                        .neutral
                        .large
                        .bold,
                    DailyText.text(
                            "Aproveite todos os benefícios do aplicativo.")
                        .body
                        .neutral
                        .small
                        .bold,
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
