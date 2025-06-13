class Claim {
  final String target;
  final String explanation;
  final List<String> url;

  Claim({
    required this.target,
    required this.explanation,
    required this.url,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      target: json['target'] ?? '',
      explanation: json['explanation'] ?? '',
      url: List<String>.from(json['url'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'explanation': explanation,
      'url': url,
    };
  }
}