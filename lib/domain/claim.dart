class Claim {
  final String target;
  final VerficationResult verificationResult;
  final String explanation;
  final List<String> url;

  Claim({
    required this.target,
    required this.verificationResult,
    required this.explanation,
    required this.url,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      target: json['target'] ?? '',
      verificationResult: VerficationResult.values[json['verification_result'] ?? 0],
      explanation: json['explanation'] ?? '',
      url: List<String>.from(json['url'] ?? []),
    );
  }
}

enum VerficationResult {
  TRUE,
  FALSE,
  UNCERTAIN,
}

