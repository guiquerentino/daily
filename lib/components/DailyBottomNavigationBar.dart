import 'package:daily/components/DailyPageView.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DailyBottomNavigationBar extends StatefulWidget {
  final Function reloadRegistro;

  const DailyBottomNavigationBar({super.key, required this.reloadRegistro});

  @override
  State<DailyBottomNavigationBar> createState() =>
      _DailyBottomNavigationBarState();
}

class _DailyBottomNavigationBarState extends State<DailyBottomNavigationBar> {
  void _showEmotionBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DailyPageView(
            reloadRegistro: widget.reloadRegistro,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: NavigationBar(
            height: constraints.maxHeight * 0.12,
            elevation: 0.5,
            backgroundColor: Colors.white,
            destinations: [
              const NavigationDestination(
                  icon: Icon(Iconsax.home,
                      size: 30, color: Color.fromRGBO(55, 52, 57, 1)),
                  label: "Home"),
              const NavigationDestination(
                  icon: Icon(Iconsax.chart_21,
                      size: 30, color: Color.fromRGBO(55, 52, 57, 1)),
                  label: "Estatísticas"),
              NavigationDestination(
                  icon: PopupMenuButton(
                    offset: const Offset(-50, -170),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'emocao',
                        child: Text('Adicionar Emoção'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'meta',
                        child: Text('Adicionar Meta'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'lembrete',
                        child: Text('Adicionar Lembrete'),
                      ),
                    ],
                    elevation: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Iconsax.add,
                          size: 30, color: Colors.white),
                    ),
                    onSelected: (value) {
                      if (value == 'emocao') {
                        _showEmotionBottomSheet(context);
                      }
                    },
                  ),
                  label: "Adicionar"),
              const NavigationDestination(
                  icon: Icon(Icons.psychology_alt_outlined,
                      size: 35, color: Color.fromRGBO(55, 52, 57, 1)),
                  label: "Saúde"),
              const NavigationDestination(
                  icon: Icon(Iconsax.profile_2user4,
                      size: 30, color: Color.fromRGBO(55, 52, 57, 1)),
                  label: "Perfil"),
            ],
          ),
        );
      },
    );
  }
}
