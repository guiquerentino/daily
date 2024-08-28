import 'package:daily/app/core/domain/providers/bottom_navigation_bar_provider.dart';
import 'package:daily/app/modules/emotions/pages/emotions_history_page.dart';
import 'package:daily/app/modules/emotions/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

final GlobalKey<_DailyBottomNavigationBarState> bottomNavigationBarKey = GlobalKey<_DailyBottomNavigationBarState>();

class DailyBottomNavigationBar extends StatefulWidget {
  const DailyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<DailyBottomNavigationBar> createState() =>
      _DailyBottomNavigationBarState();
}

class _DailyBottomNavigationBarState extends State<DailyBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    final indexNavigation = Provider.of<BottomNavigationBarProvider>(context);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.health, size: 30),
              label: 'Saúde',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.status_up, size: 30),
              label: 'Histórico',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user, size: 30),
              label: 'Perfil',
            ),
          ],
          currentIndex: indexNavigation.selectedIndex,
          selectedItemColor: const Color.fromRGBO(158, 181, 103, 1),
          onTap: (index) {
            indexNavigation.selectedIndex = index;

            switch (index) {
              case 0:
                Modular.to.navigate('/emotions${HomePage.ROUTE_NAME}');
                break;
              case 1:
                Modular.to.navigate('/health');
              case 2:
                Modular.to.navigate('/emotions${EmotionsHistoryPage.ROUTE_NAME}');
                break;
              case 3:
                Modular.to.navigate('/profile');
              default:
                break;
            }

          },
        ),
      ),
    );
  }
}
