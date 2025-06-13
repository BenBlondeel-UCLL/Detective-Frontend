import 'package:flutter/material.dart';

import '../domain/spelling_mistake.dart';
import '../constants/colors.dart';

class SpellingCard extends StatelessWidget {
  final SpellingMistake mistake;
  final String text;

  const SpellingCard({super.key, required this.mistake, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.spellingMistake),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\"${text.substring(mistake.index, mistake.index + mistake.length)}\"",
            style: TextStyle(
              color: CustomColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(mistake.message, style: TextStyle(color: CustomColors.primary)),
        ],
      ),
    );
  }
}
