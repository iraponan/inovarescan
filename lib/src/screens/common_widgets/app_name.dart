import 'package:flutter/material.dart';
import 'package:inovarescan/src/config/custom_colors.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/Logo-Inovare-TI-Branca.png',
            width: 250,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/Logo-Fundo-Transparente.png',
            width: 100,
          ),
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: 'Inovare',
                style: TextStyle(color: CustomColors.customContrastColor, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Scan',
                style: TextStyle(
                  color: CustomColors.customContrastColor2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
