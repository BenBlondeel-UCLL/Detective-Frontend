import 'package:detective/constants/sizes.dart';
import 'package:detective/domain/analysis.dart';
import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../domain/claim.dart';
import '../domain/grammar_mistake.dart';
import '../domain/spelling_mistake.dart';
import '../features/underlined_title.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
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
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadiusMedium,
                        ),
                        color: CustomColors.quaternary,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            UnderlinedTitle(title: "Analysed Article"),
                            const SizedBox(height: Sizes.defaultSpace),
                            _buildTextWithHighlights(text, response),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Sizes.spaceBetweenSectionsBig),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Sizes.borderRadiusMedium,
                            ),
                            color: CustomColors.quaternary,
                          ),
                          height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UnderlinedTitle(title: "Spelling & Grammar"),
                              const SizedBox(height: Sizes.defaultSpace),
                              SingleChildScrollView(
                                child: _buildSpellingMistakesList(
                                  response.spellingMistakes,
                                  text,
                                ),
                              ),
                              const SizedBox(height: Sizes.defaultSpace),
                              SingleChildScrollView(
                                child: _buildGrammarMistakesList(
                                  response.grammarMistakes,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Sizes.spaceBetweenSectionsBig),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Sizes.borderRadiusMedium,
                            ),
                            color: CustomColors.quaternary,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UnderlinedTitle(title: "Claims"),
                                const SizedBox(height: Sizes.defaultSpace),
                                _buildClaimsList(response.claims),
                              ],
                            ),
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

  // Function to build text with highlighted mistakes and claims
  Widget _buildTextWithHighlights(String text, Analysis analysis) {
    final List<InlineSpan> spans = [];

    // Create a map of all highlight positions
    final Map<int, List<Map<String, dynamic>>> highlightMap = {};

    // Add spelling mistakes
    for (final mistake in analysis.spellingMistakes) {
      if (!highlightMap.containsKey(mistake.index)) {
        highlightMap[mistake.index] = [];
      }
      highlightMap[mistake.index]!.add({
        'length': mistake.length,
        'type': 'spelling',
        'message': mistake.message,
      });
    }

    // Add grammar mistakes (assuming they have index and length properties)
    for (final mistake in analysis.grammarMistakes) {
      // Find the index of the grammar issue in the text
      final index = text.indexOf(mistake.target);
      if (index != -1) {
        if (!highlightMap.containsKey(index)) {
          highlightMap[index] = [];
        }
        highlightMap[index]!.add({
          'length': mistake.target.length,
          'type': 'grammar',
          'message': mistake.message,
        });
      }
    }

    // Add claims
    for (final claim in analysis.claims) {
      // Find the index of the claim in the text
      final index = text.indexOf(claim.target);
      if (index != -1) {
        if (!highlightMap.containsKey(index)) {
          highlightMap[index] = [];
        }
        highlightMap[index]!.add({
          'length': claim.target.length,
          'type': 'claim',
          'verificationResult': claim.verificationResult,
          'explanation': claim.explanation,
        });
      }
    }

    // Sort all positions
    final List<int> positions = highlightMap.keys.toList()..sort();

    int lastIndex = 0;

    // Create text spans with appropriate styling
    for (final position in positions) {
      if (position > lastIndex) {
        // Add regular text before this position
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, position),
            style: TextStyle(color: CustomColors.primary),
          ),
        );
      }

      // Process all highlights at this position
      for (final highlight in highlightMap[position]!) {
        final int length = highlight['length'];
        final String type = highlight['type'];

        Color highlightColor = Color.fromARGB(0, 0, 0, 0);
        switch (type) {
          case 'spelling':
            highlightColor = Color.fromARGB(100, 255, 0, 0);
            break;
          case 'grammar':
            highlightColor = Color.fromARGB(100, 255, 165, 0);
            break;
        }

        // Add highlighted text
        spans.add(
          TextSpan(
            text: text.substring(position, position + length),
            style: TextStyle(
              color: CustomColors.primary,
              backgroundColor: highlightColor,
              decoration: type == 'claim' ? TextDecoration.underline : null,
            ),
            // You could add a gesture recognizer here to show more info when tapped
          ),
        );

        // Update lastIndex to after this highlight
        lastIndex = position + length;
      }
    }

    // Add any remaining text
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(color: CustomColors.primary),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }

  // Build a list of spelling mistakes
  Widget _buildSpellingMistakesList(
    List<SpellingMistake> mistakes,
    String text,
  ) {
    if (mistakes.isEmpty) {
      return const Text(
        "No spelling mistakes found.",
        style: TextStyle(color: CustomColors.primary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Spelling mistakes: ${mistakes.length}",
          style: TextStyle(
            color: CustomColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...mistakes.map(
          (mistake) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(100, 255, 0, 0)),
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
                  Text(
                    mistake.message,
                    style: TextStyle(color: CustomColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build a list of grammar mistakes
  Widget _buildGrammarMistakesList(List<GrammarMistake> mistakes) {
    if (mistakes.isEmpty) {
      return const Text(
        "No grammar issues found.",
        style: TextStyle(color: CustomColors.primary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Grammar issues: ${mistakes.length}",
          style: TextStyle(
            color: CustomColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...mistakes.map(
          (mistake) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(100, 255, 165, 0)),
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
            ),
          ),
        ),
      ],
    );
  }

  // Build a list of claims and their verification status
  Widget _buildClaimsList(List<Claim> claims) {
    if (claims.isEmpty) {
      return const Text(
        "No claims detected for verification.",
        style: TextStyle(color: CustomColors.primary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verified claims: ${claims.length}",
          style: TextStyle(
            color: CustomColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...claims.map((claim) {
          Color borderColor;
          String statusText;

          switch (claim.verificationResult) {
            case VerificationResult.TRUE:
              borderColor = Colors.green;
              statusText = "True";
              break;
            case VerificationResult.UNCERTAIN:
              borderColor = Colors.orange;
              statusText = "Uncertain";
              break;
            case VerificationResult.FALSE:
              borderColor = Colors.red;
              statusText = "False";
              break;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          claim.target,
                          style: TextStyle(
                            color: CustomColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    claim.explanation,
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  if (claim.url.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Sources:",
                      style: TextStyle(
                        color: CustomColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...claim.url.map(
                      (url) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          url,
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
