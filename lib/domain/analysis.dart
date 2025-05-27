import 'package:detective/domain/spelling_mistake.dart';
import 'grammar_mistake.dart';
import 'claim.dart';

class Analysis {
  final List<SpellingMistake> spellingMistakes;
  final List<GrammarMistake> grammarMistakes;
  final List<Claim> claims;
  final bool aiContents;

  Analysis({
    required this.spellingMistakes,
    required this.grammarMistakes,
    required this.claims,
    required this.aiContents,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      spellingMistakes: (json['spellingMistakes'] as List?)
          ?.map((item) => SpellingMistake.fromJson(item))
          .toList() ??
          [],
      grammarMistakes: (json['grammarMistakes'] as List?)
          ?.map((item) => GrammarMistake.fromJson(item))
          .toList() ??
          [],
      claims: (json['claims'] as List?)
          ?.map((item) => Claim.fromJson(item))
          .toList() ??
          [],
      aiContents: (json['aiContent'] as bool)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spellingMistakes': spellingMistakes.map((item) => item.toJson()).toList(),
      'grammarMistakes': grammarMistakes.map((item) => item.toJson()).toList(),
      'claims': claims.map((item) => item.toJson()).toList(),
      'aiContent': aiContents,
    };
  }
}