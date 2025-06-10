import 'package:critify/constants/news_site_translation.dart';

class NewsSite {
  final String name;
  final String url;
  final String bias;
  final String factual;
  final String credibility;

  NewsSite({
    required this.name,
    required this.url,
    required this.bias,
    required this.factual,
    required this.credibility,
  });

  factory NewsSite.fromJson(Map<String, dynamic> json) {
    return NewsSite(
      name: json['name'] as String,
      url: json['url'] as String,
      bias: getTranslatedBias(json['bias'] as String),
      factual: getTranslatedFactual(json['factual'] as String),
      credibility: getTranslatedCredibility(json['credibility'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'bias': bias,
      'factual': factual,
      'credibility': credibility,
    };
  }
}