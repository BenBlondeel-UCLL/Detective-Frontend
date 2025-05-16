import 'package:detective/constants/sizes.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text:
            '"The pencil case is being reimagined", says Andrea Chen', // TODO: Change to second quote from news article
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: Sizes.spaceBetweenItems),
        RichText(
          text: TextSpan(
            text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', // TODO: Change to second quote analysis
          ),
        ),
      ],
    );
  }
}
