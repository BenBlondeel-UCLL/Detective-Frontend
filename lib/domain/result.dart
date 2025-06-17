import 'grammar_mistake.dart';
import 'claim.dart';

import '../domain/news_site.dart';
import '../domain/spelling_mistake.dart';

class Result {
  final List<SpellingMistake> spellingMistakes;
  final List<GrammarMistake> grammarMistakes;
  final List<Claim> claims;
  final num arousalScore;
  final bool aiContent;
  final NewsSite newsSite;

  Result({
    required this.spellingMistakes,
    required this.grammarMistakes,
    required this.claims,
    required this.arousalScore,
    required this.aiContent,
    required this.newsSite,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      spellingMistakes:
          (json['spellingMistakes'] as List?)
              ?.map((item) => SpellingMistake.fromJson(item))
              .toList() ??
          [],
      grammarMistakes:
          (json['grammarMistakes'] as List?)
              ?.map((item) => GrammarMistake.fromJson(item))
              .toList() ??
          [],
      claims:
          (json['claims'] as List?)
              ?.map((item) => Claim.fromJson(item))
              .toList() ??
          [],
      arousalScore: (json['arousal_score'] as num?) ?? 0.0,
      aiContent: (json['aiContent'] as bool),
      newsSite: NewsSite.fromJson(json['newsSite'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spellingMistakes':
          spellingMistakes.map((item) => item.toJson()).toList(),
      'grammarMistakes': grammarMistakes.map((item) => item.toJson()).toList(),
      'claims': claims.map((item) => item.toJson()).toList(),
      'arousal_score': arousalScore,
      'aiContent': aiContent,
      'newsSite': newsSite.toJson(),
    };
  }
}
