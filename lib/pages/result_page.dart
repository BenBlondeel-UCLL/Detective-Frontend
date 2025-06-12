import 'dart:convert';

import 'package:critify/constants/sizes.dart';
import 'package:critify/domain/analysis_by_id.dart';
import 'package:critify/domain/result.dart';
import 'package:critify/features/claim_card.dart';
import 'package:critify/features/grammar_card.dart';
import 'package:critify/features/header.dart';
import 'package:critify/features/history_drawer.dart';
import 'package:critify/features/link_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import '../domain/claim.dart';
import '../domain/grammar_mistake.dart';
import '../domain/news_site.dart';
import '../domain/spelling_mistake.dart';
import '../features/spelling_card.dart';
import '../features/underlined_title.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {
  AnalysisById _analysisById = AnalysisById(
    id: "",
    article: "",
    result: Result(
      spellingMistakes: [],
      grammarMistakes: [],
      claims: [],
      aiContent: false,
      arousalScore: 0.0,
      newsSite: NewsSite(name: "", url: "", bias: "", factual: "", credibility: ""),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  @override
  void dispose() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('currentAnalysis');
    });
    super.dispose();
  }

  void _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _analysisById = AnalysisById.fromJson(jsonDecode(prefs.getString('currentAnalysis')!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 900;
    final horizontalPadding = isLargeScreen ? 64.0 : 16.0;

    return Scaffold(
      drawer: HistoryDrawer(),
      body: Column(
        children: [
          Header(title: "Analyse"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isLargeScreen ? 32 : 16,
                horizontal: horizontalPadding,
              ),
              child: isLargeScreen ? _buildWideLayout() : _buildNarrowLayout(),
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
        Expanded(flex: 5, child: _buildArticleContainer()),
        const SizedBox(width: Sizes.spaceBetweenSections),
        Expanded(flex: 5, child: _buildAnalysisTabsContainer()),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        SizedBox(height: 300, child: _buildArticleContainer()),
        const SizedBox(height: 16),
        Expanded(child: _buildAnalysisTabsContainer()),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: UnderlinedTitle(title: "Geanalyseerd Artikel"),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [_buildTextWithHighlights(_analysisById.article, _analysisById.result)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primary,
                  foregroundColor: CustomColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.buttonRadius),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                ),
                child: const Text(
                  "Analyseer een ander artikel",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTabsContainer() {
    return DefaultTabController(
      length: 4,
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
              tabs: [
                Tab(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: SizedBox(
                          width: 80, // Set a max width for the label
                          child: Center(
                            child : Text(
                              "Spelling",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Text("${_analysisById.result.spellingMistakes.length}"),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: SizedBox(
                          width: 80, // Set a max width for the label
                          child: Center(
                            child : Text(
                              "Grammatica",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Text("${_analysisById.result.grammarMistakes.length}"),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: SizedBox(
                          width: 80, // Set a max width for the label
                          child: Center(
                            child : Text(
                              "Stellingen",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Text("${_analysisById.result.claims.length}"),
                    ],
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: 80, // Set a max width for the label
                    child: Center(
                      child : Text(
                        "Extra",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
              labelColor: CustomColors.primary,
              indicatorColor: CustomColors.primary,
              unselectedLabelColor: CustomColors.primary.withValues(alpha: 0.6),
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
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _buildSpellingMistakesList(
                        _analysisById.result.spellingMistakes,
                        _analysisById.article,
                      ),
                    ),
                  ),
                  // Grammar tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _buildGrammarMistakesList(
                        _analysisById.result.grammarMistakes,
                      ),
                    ),
                  ),
                  // Claims tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _buildClaimsList(_analysisById.result.claims),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _buildScoresContentsList(
                        _analysisById.result.aiContent,
                        _analysisById.result.arousalScore,
                        _analysisById.result.newsSite,
                      ),
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

  Widget _buildTextWithHighlights(String text, Result response) {
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
      },
    );

    // Apply grammar mistake highlights (yellow background)
    for (var mistake in response.grammarMistakes) {
      int index = text.indexOf(mistake.target);
      if (index != -1) {
        for (
          int i = index;
          i < index + mistake.target.length && i < text.length;
          i++
        ) {
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

    // Apply claim highlights
    for (var claim in response.claims) {
      int index = text.indexOf(claim.target);
      if (index != -1) {
        for (
          int i = index;
          i < index + claim.target.length && i < text.length;
          i++
        ) {
          styles[i]['decoration'] = TextDecoration.underline;
          styles[i]['decorationColor'] = Colors.black;
        }
      }
    }

    // Build text spans by grouping characters with the same styling
    List<InlineSpan> spans = [];
    String currentText = '';
    Map<String, dynamic>? currentStyle =
        styles.isNotEmpty ? Map.from(styles[0]) : null;

    for (int i = 0; i < text.length; i++) {
      bool styleChanged =
          i > 0 &&
          (styles[i]['color'] != currentStyle?['color'] ||
              styles[i]['backgroundColor'] !=
                  currentStyle?['backgroundColor'] ||
              styles[i]['decoration'] != currentStyle?['decoration'] ||
              styles[i]['decorationColor'] != currentStyle?['decorationColor']);

      if (styleChanged) {
        // Add the accumulated text with previous style
        spans.add(
          TextSpan(
            text: currentText,
            style: TextStyle(
              color: currentStyle?['color'],
              backgroundColor: currentStyle?['backgroundColor'],
              decoration: currentStyle?['decoration'],
              decorationColor: currentStyle?['decorationColor'],
            ),
          ),
        );

        // Reset for new style
        currentText = '';
        currentStyle = Map.from(styles[i]);
      }

      currentText += text[i];
    }

    // Add the last span
    if (currentText.isNotEmpty && currentStyle != null) {
      spans.add(
        TextSpan(
          text: currentText,
          style: TextStyle(
            color: currentStyle['color'],
            backgroundColor: currentStyle['backgroundColor'],
            decoration: currentStyle['decoration'],
            decorationColor: currentStyle['decorationColor'],
          ),
        ),
      );
    }

    return SelectableText.rich(TextSpan(children: spans));
  }

  Widget _buildScoresContentsList(
    bool aiContents,
    num arousalScore,
    NewsSite newsSite,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("AI Check:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: Sizes.spaceBetweenTextAndUnderline),
              Text(
                aiContents
                    ? "Deze tekst is waarschijnlijk AI gegenereerd."
                    : "Deze tekst is waarschijnlijk door een mens geschreven.",
                style: TextStyle(
                  color: CustomColors.primary.withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: Sizes.spaceBetweenSections),
              Text(
                "Sensatiewaarde: $arousalScore",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Sizes.spaceBetweenTextAndUnderline),
              Text(
                "Een waare van 0 tot 1. Deze waarde duidt op de opwekking van emoties in the tekst. Een hogere waarde suggereert dat de tekst meer emoties opwekt.",
                style: TextStyle(
                  color: CustomColors.primary.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: Sizes.spaceBetweenSections),
              Text(
                "Waarschijnlijke Bron:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Sizes.spaceBetweenTextAndUnderline),
              Text("\t\tNaam: ${newsSite.name}"),
              Row(
                children: [
                  Text("\t\tURL: "),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse("https://${newsSite.url}");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: Text(
                      newsSite.url,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              Text("\t\tPartijdigheid: ${newsSite.bias}"),
              Text("\t\tFeitelijkheid: ${newsSite.factual}"),
              Text("\t\tBetrouwbaarheid: ${newsSite.credibility}"),
              const SizedBox(height: Sizes.spaceBetweenItems),
              Text(
                "Deze informatie komt van:",
                style: TextStyle(
                  color: CustomColors.primary.withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
              LinkText(
                title: "Media Bias/Fact Check API",
                url: "https://mediabiasfactcheck.com/mbfcs-data-api/",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpellingMistakesList(
    List<SpellingMistake> mistakes,
    String text,
  ) {
    if (mistakes.isEmpty) {
      return const Text(
        "Geen spelling fouten gevonden.",
        style: TextStyle(color: CustomColors.primary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...mistakes.map(
          (mistake) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SpellingCard(mistake: mistake, text: text),
          ),
        ),
      ],
    );
  }

  Widget _buildGrammarMistakesList(List<GrammarMistake> mistakes) {
    if (mistakes.isEmpty) {
      return const Text(
        "Geen grammatica fouten gevonden.",
        style: TextStyle(color: CustomColors.primary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...mistakes.map(
          (mistake) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GrammarCard(mistake: mistake),
          ),
        ),
      ],
    );
  }

  Widget _buildClaimsList(List<Claim> claims) {
    if (claims.isEmpty) {
      return const Text(
        "Geen stellingen gedetecteerd voor verificatie.",
        style: TextStyle(color: CustomColors.primary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...claims.map((claim) {
          return ClaimCard(claim: claim);
        }),
      ],
    );
  }
}
