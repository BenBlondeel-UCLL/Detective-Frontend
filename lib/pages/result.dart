import 'package:detective/constants/sizes.dart';
import 'package:detective/domain/analysis.dart';
import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';
import 'package:detective/features/quote_card.dart';

import '../constants/colors.dart';
import '../features/underlined_title.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final Analysis response = args?['response'];
    final String text = args?['text'];

    return Scaffold(
      body: Column(
        children: [
          const Header(title: "Analysis"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                        color: CustomColors.quaternary,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            UnderlinedTitle(title: "Analysed Article"),
                            const SizedBox(height: Sizes.defaultSpace),
                            RichText(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(
                                  color: CustomColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                  const SizedBox(width: Sizes.spaceBetweenSectionsBig),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container (
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                            color: CustomColors.quaternary,
                          ),
                          child: Column(
                            children: [
                              UnderlinedTitle(title: "Analysis"),
                              const SizedBox(height: Sizes.defaultSpace),
                              RichText(
                                text: TextSpan(
                                  text:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', // TODO: Change to analysis
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Sizes.spaceBetweenSectionsBig),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                            color: CustomColors.quaternary,
                          ),
                          child: Column(
                            children: [
                              UnderlinedTitle(title: "Quotes"),
                              const SizedBox(height: Sizes.defaultSpace),
                              QuoteCard(quote: 'More than 70% of all student have resorted back to using pencil cases', analysis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                              const SizedBox(height: Sizes.spaceBetweenSections),
                              QuoteCard(quote: '"The pencil case is being reimagined", says Andrea Chen', analysis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
