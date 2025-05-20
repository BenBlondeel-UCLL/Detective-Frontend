class GrammarMistake {
  final String target;
  final String code;
  final String message;

  GrammarMistake({
    required this.target,
    required this.code,
    required this.message,
  });

  factory GrammarMistake.fromJson(Map<String, dynamic> json) {
    return GrammarMistake(
      target: json['target'] ?? '',
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }
}