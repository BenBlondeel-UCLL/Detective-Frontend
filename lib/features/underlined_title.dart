import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class UnderlinedTitle extends StatelessWidget {
  final String title;

  const UnderlinedTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: CustomColors.primary,
          ),
        ),
        const SizedBox(height: Sizes.spaceBetweenTextAndUnderline),
        Container(
          width: 160,
          height: 2,
          color: CustomColors.primary,
        ),
      ],
    );
  }
}