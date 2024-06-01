import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SvgPicture.asset('assets/loginbar.svg',width: screenWidth,);
  }
}
