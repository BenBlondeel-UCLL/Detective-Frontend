import 'dart:convert';

import 'package:detective/constants/sizes.dart';
import 'package:detective/domain/analysis.dart';
import 'package:detective/features/claim_card.dart';
import 'package:detective/features/grammar_card.dart';
import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../domain/claim.dart';
import '../domain/grammar_mistake.dart';
import '../domain/spelling_mistake.dart';
import '../features/spelling_card.dart';
import '../features/underlined_title.dart';

class Result extends StatefulWidget {
  @override
  _Result createState() => _Result();
}

class _Result extends State<Result> {
  Analysis _response = Analysis(spellingMistakes: [], grammarMistakes: [], claims: []);
  String _text = "";

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  void _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _response = Analysis.fromJson(jsonDecode(prefs.getString('response')!));
      _text = prefs.getString('text') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 900;
    final horizontalPadding = isLargeScreen ? 64.0 : 16.0;

    return Scaffold(
      body: Column(
        children: [
          const Header(title: "Analysis"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: isLargeScreen ? 32 : 16,
                  horizontal: horizontalPadding
              ),
              child: isLargeScreen
                  ? _buildWideLayout()
                  : _buildNarrowLayout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _buildArticleContainer(),
        ),
        const SizedBox(width: Sizes.spaceBetweenSections),
        Expanded(
          flex: 4,
          child: _buildAnalysisTabsContainer(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: _buildArticleContainer(),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _buildAnalysisTabsContainer(),
        ),
      ],
    );
  }

  Widget _buildArticleContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
        color: CustomColors.quaternary,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            UnderlinedTitle(title: "Analysed Article"),
            const SizedBox(height: Sizes.defaultSpace),
            _buildTextWithHighlights(_text, _response),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisTabsContainer() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomColors.quaternary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Sizes.borderRadiusMedium),
                topRight: Radius.circular(Sizes.borderRadiusMedium),
              ),
            ),
            child: TabBar(
              tabs: const [
                Tab(text: "Spelling"),
                Tab(text: "Grammar"),
                Tab(text: "Claims"),
              ],
              labelColor: CustomColors.primary,
              indicatorColor: CustomColors.primary,
              unselectedLabelColor: CustomColors.primary.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.borderRadiusMedium),
                  bottomRight: Radius.circular(Sizes.borderRadiusMedium),
                ),
                color: CustomColors.quaternary,
              ),
              width: double.infinity,
              child: TabBarView(
                children: [
                  // Spelling tab
                  SingleChildScrollView(
                    child: _buildSpellingMistakesList(
                      _response.spellingMistakes,
                      _text,
                    ),
                  ),
                  // Grammar tab
                  SingleChildScrollView(
                    child: _buildGrammarMistakesList(
                      _response.grammarMistakes,
                    ),
                  ),
                  // Claims tab
                  SingleChildScrollView(
                    child: _buildClaimsList(_response.claims),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildTextWithHighlights(String text, Analysis response) {
  // If text is empty, return empty container
  if (text.isEmpty) {
    return Container();
  }

  // Create a list to track styling for each character
  List<Map<String, dynamic>> styles = List.generate(
    text.length,
    (_) => {
      'color': CustomColors.primary,
      'backgroundColor': null,
      'decoration': null,
      'decorationColor': null,
    }
  );

  // Apply grammar mistake highlights (yellow background)
  for (var mistake in response.grammarMistakes) {
    int index = text.indexOf(mistake.target);
    if (index != -1) {
      for (int i = index; i < index + mistake.target.length && i < text.length; i++) {
        styles[i]['backgroundColor'] = CustomColors.grammarMistake;
      }
    }
  }

  // Apply spelling mistake highlights (red text)
  for (var mistake in response.spellingMistakes) {
    int start = mistake.index;
    int end = start + mistake.length;

    for (int i = start; i < end && i < text.length; i++) {
      styles[i]['color'] = CustomColors.spellingMistake;
    }
  }

  // Apply claim highlights (underline with color based on verification)
  for (var claim in response.claims) {
    int index = text.indexOf(claim.target);
    if (index != -1) {
      Color decorationColor;
      switch (claim.verificationResult) {
        case VerificationResult.TRUE:
          decorationColor = Colors.green;
          break;
        case VerificationResult.FALSE:
          decorationColor = Colors.red;
          break;
        case VerificationResult.UNCERTAIN:
          decorationColor = Colors.orange;
          break;
      }

      for (int i = index; i < index + claim.target.length && i < text.length; i++) {
        styles[i]['decoration'] = TextDecoration.underline;
        styles[i]['decorationColor'] = decorationColor;
      }
    }
  }

  // Build text spans by grouping characters with the same styling
  List<InlineSpan> spans = [];
  String currentText = '';
  Map<String, dynamic>? currentStyle = styles.isNotEmpty ? Map.from(styles[0]) : null;

  for (int i = 0; i < text.length; i++) {
    bool styleChanged = i > 0 && (
      styles[i]['color'] != currentStyle?['color'] ||
      styles[i]['backgroundColor'] != currentStyle?['backgroundColor'] ||
      styles[i]['decoration'] != currentStyle?['decoration'] ||
      styles[i]['decorationColor'] != currentStyle?['decorationColor']
    );

    if (styleChanged) {
      // Add the accumulated text with previous style
      spans.add(TextSpan(
        text: currentText,
        style: TextStyle(
          color: currentStyle?['color'],
          backgroundColor: currentStyle?['backgroundColor'],
          decoration: currentStyle?['decoration'],
          decorationColor: currentStyle?['decorationColor'],
        ),
      ));

      // Reset for new style
      currentText = '';
      currentStyle = Map.from(styles[i]);
    }

    currentText += text[i];
  }

  // Add the last span
  if (currentText.isNotEmpty && currentStyle != null) {
    spans.add(TextSpan(
      text: currentText,
      style: TextStyle(
        color: currentStyle['color'],
        backgroundColor: currentStyle['backgroundColor'],
        decoration: currentStyle['decoration'],
        decorationColor: currentStyle['decorationColor'],
      ),
    ));
  }

  return SelectableText.rich(
    TextSpan(children: spans),
  );
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
