import 'package:flutter/material.dart';

class AnotherBottomSheet extends StatelessWidget {
  const AnotherBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        color: const Color.fromRGBO(245, 245, 245, 1),
        child: Center(
          child: Text(
            "Nova Tela",
            style: TextStyle(fontSize: 22, fontFamily: 'Pangram'),
          ),
        ),
      ),
    );
  }
}
