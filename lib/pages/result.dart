import 'package:detective/constants/sizes.dart';
import 'package:detective/domain/analysis.dart';
import 'package:detective/features/claim_card.dart';
import 'package:detective/features/grammar_card.dart';
import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../domain/claim.dart';
import '../domain/grammar_mistake.dart';
import '../domain/spelling_mistake.dart';
import '../features/spelling_card.dart';
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
                    flex: 5,
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
                  const SizedBox(width: Sizes.spaceBetweenSections),
                  Expanded(
                    flex: 5,
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
                          width: double.infinity,
                          height: 250,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UnderlinedTitle(title: "Spelling & Grammar"),
                                const SizedBox(height: Sizes.defaultSpace),
                                _buildSpellingMistakesList(
                                  response.spellingMistakes,
                                  text,
                                ),
                                const SizedBox(height: Sizes.defaultSpace),
                                _buildGrammarMistakesList(
                                  response.grammarMistakes,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.spaceBetweenSections),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Sizes.borderRadiusMedium,
                            ),
                            color: CustomColors.quaternary,
                          ),
                          width: double.infinity,
                          height: 250,
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

  Widget _buildTextWithHighlights(String text, Analysis analysis) {
    final List<InlineSpan> spans = [];

    final List<Map<String, dynamic>> allHighlights = [];

    for (final mistake in analysis.spellingMistakes) {
      allHighlights.add({
        'start': mistake.index,
        'end': mistake.index + mistake.length,
        'type': 'spelling',
        'message': mistake.message,
      });
    }

    for (final mistake in analysis.grammarMistakes) {
      final index = text.indexOf(mistake.target);
      if (index != -1) {
        allHighlights.add({
          'start': index,
          'end': index + mistake.target.length,
          'type': 'grammar',
          'message': mistake.message,
        });
      }
    }

    for (final claim in analysis.claims) {
      final index = text.indexOf(claim.target);
      if (index != -1) {
        allHighlights.add({
          'start': index,
          'end': index + claim.target.length,
          'type': 'claim',
          'verificationResult': claim.verificationResult,
          'explanation': claim.explanation,
        });
      }
    }

    allHighlights.sort((a, b) {
      final startComparison = a['start'].compareTo(b['start']);
      if (startComparison == 0) {
        return b['end'].compareTo(a['end']);
      }
      return startComparison;
    });

    if (allHighlights.isEmpty) {
      spans.add(TextSpan(
        text: text,
        style: TextStyle(color: CustomColors.primary),
      ));
    } else {
      int lastIndex = 0;

      final List<Map<String, dynamic>> activeHighlights = [];

      for (int i = 0; i < text.length; i++) {
        bool highlightsChanged = false;

        for (final highlight in allHighlights) {
          if (highlight['start'] == i) {
            activeHighlights.add(highlight);
            highlightsChanged = true;
          }
        }

        for (int j = activeHighlights.length - 1; j >= 0; j--) {
          if (activeHighlights[j]['end'] == i) {
            activeHighlights.removeAt(j);
            highlightsChanged = true;
          }
        }

        if (highlightsChanged || i == text.length - 1) {
          if (i > lastIndex) {
            final spanText = text.substring(lastIndex, i);

            if (activeHighlights.isEmpty) {
              spans.add(
                TextSpan(
                  text: spanText,
                  style: TextStyle(color: CustomColors.primary),
                ),
              );
            } else {
              Color textColor = CustomColors.primary;
              Color backgroundColor = Colors.transparent;
              TextDecoration textDecoration = TextDecoration.none;
              Color decorationColor = Colors.transparent;

              for (final highlight in activeHighlights) {
                switch (highlight['type']) {
                  case 'spelling':
                    textColor = CustomColors.spellingMistake;
                    break;
                  case 'grammar':
                    backgroundColor = CustomColors.grammarMistake;
                    break;
                  case 'claim':
                    textDecoration = TextDecoration.underline;
                    decorationColor = Colors.black;
                    break;
                }
              }

              spans.add(
                TextSpan(
                  text: spanText,
                  style: TextStyle(
                    color: textColor,
                    backgroundColor: backgroundColor,
                    decoration: textDecoration,
                    decorationColor: decorationColor,
                  ),
                ),
              );
            }
          }

          lastIndex = i;
        }
      }

      if (lastIndex < text.length) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex),
            style: TextStyle(color: CustomColors.primary),
          ),
        );
      }
    }

    return RichText(text: TextSpan(children: spans));
  }

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
            child: SpellingCard(
              mistake: mistake,
              text: text,
            ),
          ),
        ),
      ],
    );
  }

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
            child: GrammarCard(
              mistake: mistake,
            ),
          ),
        ),
      ],
    );
  }

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
          return ClaimCard(
            claim: claim,
          );
        }),
      ],
    );
  }
}
