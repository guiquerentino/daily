import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/domain/providers/bottom_navigation_bar_provider.dart';
import '../../emotions/pages/home_page.dart';
import '../../ui/daily_text.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool faceID = false;
  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Provider.of<BottomNavigationBarProvider>(context,
                            listen: false)
                        .selectedIndex = 0;
                    Modular.to.navigate('/emotions${HomePage.ROUTE_NAME}');
                  },
                ),
                DailyText.text("Preferências").header.medium.bold,
                Container(),
                Container(),
              ],
            ),
            const Gap(20),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * .38,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Face ID",
                            style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 20,
                            )),
                        Switch(
                          activeColor: const Color.fromRGBO(158, 181, 103, 1),
                            value: faceID,
                            onChanged: (value) {
                              setState(() {
                                faceID = value;
                              });
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Notificações",
                            style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 20,
                            )),
                        Switch(
                            activeColor: const Color.fromRGBO(158, 181, 103, 1),
                            value: notifications,
                            onChanged: (value) {
                              setState(() {
                                notifications = value;
                              });
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Modo Noturno",
                            style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 20,
                            )),
                        Switch(
                            activeColor: const Color.fromRGBO(158, 181, 103, 1),
                            value: darkMode,
                            onChanged: (value) {
                              setState(() {
                                darkMode = value;
                              });
                            })
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Métodos de pagamento",
                            style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 20,
                            )),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sobre nós",
                            style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 20,
                            )),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Política de privacidade",
                            style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 20,
                            )),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
