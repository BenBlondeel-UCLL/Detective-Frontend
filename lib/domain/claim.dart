class Claim {
  final String target;
  final VerificationResult verificationResult;
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
      verificationResult: VerificationResult.values[json['verification_result'] ?? 0],
      explanation: json['explanation'] ?? '',
      url: List<String>.from(json['url'] ?? []),
    );
  }
}

enum VerificationResult {
  TRUE,
  FALSE,
  UNCERTAIN,
}

