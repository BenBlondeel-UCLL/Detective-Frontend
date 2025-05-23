import 'package:detective/domain/grammar_mistake.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class GrammarCard extends StatelessWidget {
  final GrammarMistake mistake;

  const GrammarCard({super.key, required this.mistake});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.grammarMistake),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\"${mistake.target}\"",
            style: TextStyle(
              color: CustomColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            mistake.message,
            style: TextStyle(color: CustomColors.primary),
          ),
          Text(
            "Code: ${mistake.code}",
            style: TextStyle(color: CustomColors.primary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
