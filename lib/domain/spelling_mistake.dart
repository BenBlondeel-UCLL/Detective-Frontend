class SpellingMistake {
  final String target;
  final String code;
  final int index;
  final int length;
  final String message;

  SpellingMistake({
    required this.target,
    required this.code,
    required this.index,
    required this.length,
    required this.message,
  });

  factory SpellingMistake.fromJson(Map<String, dynamic> json) {
    return SpellingMistake(
      target: json['target'] ?? '',
      code: json['code'] ?? '',
      index: json['index'] ?? -1,
      length: json['length'] ?? -1,
      message: json['message'] ?? '',
    );
  }
}