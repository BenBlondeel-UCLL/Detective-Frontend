import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class UnderlinedTitle extends StatelessWidget {
  final String title;
  final Color color;

  const UnderlinedTitle({super.key, required this.title, this.color = CustomColors.primary});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Sizes.fontSizeBig,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: Sizes.spaceBetweenTextAndUnderline),
          Container(
            height: 2,
            color: color,
          ),
        ],
      ),
    );
  }
}