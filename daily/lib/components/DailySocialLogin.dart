import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DailySocialLogin extends StatelessWidget {
  const DailySocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 63,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 8)
              ],
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          child: Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit: BoxFit.cover),
        ),
        const Gap(9),
        Container(
          height: 60,
          width: 63,
          decoration: const BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 8)
              ],
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          child: const Icon(Icons.apple,
              color: Color.fromRGBO(255, 255, 255, 1), size: 44),
        ),
        const Gap(9),
        Container(
          height: 60,
          width: 63,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(24, 119, 242, 1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 8)
              ],
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          child: const Icon(
            Icons.facebook,
            size: 44,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
