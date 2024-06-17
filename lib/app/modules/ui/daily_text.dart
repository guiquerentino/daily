import 'package:flutter/material.dart';

class DailyText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final bool ellipsis;

  const DailyText._({
    Key? key,
    required this.text,
    required this.fontFamily,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    this.ellipsis = false,
  }) : super(key: key);

  factory DailyText.text(String text) {
    return DailyText._(
      text: text,
      fontFamily: 'Pangram',
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      color: Colors.black,
    );
  }

  DailyText get small {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize == 16.0 ? 12.0 : 20.0,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get medium {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize == 16.0 ? 14.0 : 28.0,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get withEllipsis {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      ellipsis: true,
    );
  }

  DailyText get large {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize == 16.0 ? 16.0 : 36.0,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get regular {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get mediumWeight {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get bold {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get header {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: 36.0,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get body {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: 16.0,
      color: color,
      ellipsis: ellipsis,
    );
  }

  DailyText get success {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: Colors.green,
      ellipsis: ellipsis,
    );
  }

  DailyText get danger {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: Colors.red,
      ellipsis: ellipsis,
    );
  }

  DailyText get neutral {
    return DailyText._(
      text: text,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: Colors.white,
      ellipsis: ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
      overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.clip,
    );
  }
}
