import 'package:critify/constants/sizes.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String analysis;

  const QuoteCard({super.key, required this.quote, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: quote,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: Sizes.spaceBetweenItems),
        RichText(
          text: TextSpan(
            text: analysis,
          ),
        ),
      ],
    );
  }
}
