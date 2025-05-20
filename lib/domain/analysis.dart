import 'package:detective/domain/spelling_mistake.dart';
import 'grammar_mistake.dart';
import 'claim.dart';

class Analysis {
  final List<SpellingMistake> spellingMistakes;
  final List<GrammarMistake> grammarMistakes;
  final List<Claim> claims;

  Analysis({
    required this.spellingMistakes,
    required this.grammarMistakes,
    required this.claims,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      spellingMistakes: (json['spelling_mistakes'] as List?)
          ?.map((item) => SpellingMistake.fromJson(item))
          .toList() ??
          [],
      grammarMistakes: (json['grammar_mistakes'] as List?)
          ?.map((item) => GrammarMistake.fromJson(item))
          .toList() ??
          [],
      claims: (json['claims'] as List?)
          ?.map((item) => Claim.fromJson(item))
          .toList() ??
          [],
    );
  }
}