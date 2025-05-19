import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class UnderlinedTitle extends StatelessWidget {
  final String title;

  const UnderlinedTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: Sizes.fontSizeBig,
              fontWeight: FontWeight.w900,
              color: CustomColors.primary,
            ),
          ),
          const SizedBox(height: Sizes.spaceBetweenTextAndUnderline),
          Container(
            height: 2,
            color: CustomColors.primary,
          ),
        ],
      ),
    );
  }
}