import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DailyBottomNavigationBar extends StatefulWidget {
  const DailyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<DailyBottomNavigationBar> createState() =>
      _DailyBottomNavigationBarState();
}

class _DailyBottomNavigationBarState extends State<DailyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            offset: Offset(0, 3)
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
         100
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixa o tipo
          elevation: 0, // Remove a sombra padrão do BottomNavigationBar
          backgroundColor: Colors.transparent, // Define o fundo como transparente para usar o container
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.map, size: 30),
              label: 'Explorar',
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
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(158, 181, 103, 1),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
