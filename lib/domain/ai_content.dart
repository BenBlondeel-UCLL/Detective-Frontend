class AiContent {
  final String target;
  final bool isAiGenerated;

  AiContent({
    required this.target,
    required this.isAiGenerated,
  });

  factory AiContent.fromJson(Map<String, dynamic> json) {
    return AiContent(
      target: json['target'] ?? '',
      isAiGenerated: json['ai'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'ai': isAiGenerated,
    };
  }
}