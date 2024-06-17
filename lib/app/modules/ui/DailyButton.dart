import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';

class DailyButton extends StatefulWidget {
  final DailyText text;
  final VoidCallback onPressed;

  const DailyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<DailyButton> createState() => _DailyButtonState();
}

class _DailyButtonState extends State<DailyButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,
      child: widget.text,
      style: const ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Color.fromRGBO(53, 56, 63, 1)),
        fixedSize: MaterialStatePropertyAll(Size(200, 40)),
      ),
    );
  }
}
