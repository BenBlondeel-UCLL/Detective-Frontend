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
      verificationResult: _parseVerificationResult(json['verification_result']),
      explanation: json['explanation'] ?? '',
      url: List<String>.from(json['url'] ?? []),
    );
  }

  static VerificationResult _parseVerificationResult(dynamic value) {
    if (value == 'TRUE') return VerificationResult.TRUE;
    if (value == 'FALSE') return VerificationResult.FALSE;
    return VerificationResult.UNCERTAIN;
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'verification_result': verificationResult.toString().split('.').last,
      'explanation': explanation,
      'url': url,
    };
  }
}

enum VerificationResult {
  TRUE,
  FALSE,
  UNCERTAIN,
}

