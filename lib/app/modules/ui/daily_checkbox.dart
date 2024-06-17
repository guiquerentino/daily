import 'package:flutter/material.dart';

class DailyCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onClicked;

  const DailyCheckbox({
    super.key,
    required this.value,
    required this.onClicked,
  });

  @override
  State<DailyCheckbox> createState() => _DailyCheckboxState();
}

class _DailyCheckboxState extends State<DailyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29.0,
      width: 29.0,
      child: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.black,
        value: widget.value,
        onChanged: widget.onClicked, // Passando a função diretamente
      ),
    );
  }
}
