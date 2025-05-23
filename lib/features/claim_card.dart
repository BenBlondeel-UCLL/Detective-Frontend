import 'package:detective/domain/claim.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ClaimCard extends StatelessWidget {
  final Claim claim;

  const ClaimCard({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    Color borderColor;

    switch (claim.verificationResult) {
      case VerificationResult.TRUE:
        borderColor = Colors.green;
        break;
      case VerificationResult.UNCERTAIN:
        borderColor = Colors.orange;
        break;
      case VerificationResult.FALSE:
        borderColor = Colors.red;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    claim.verificationResult.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    claim.target,
                    style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              claim.explanation,
              style: TextStyle(color: CustomColors.primary),
            ),
            if (claim.url.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                "Sources:",
                style: TextStyle(
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...claim.url.map(
                    (url) => Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    url,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}