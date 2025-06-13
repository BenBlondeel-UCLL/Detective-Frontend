import 'package:critify/features/link_text.dart';
import 'package:flutter/material.dart';

import '../domain/claim.dart';
import '../constants/colors.dart';

class ClaimCard extends StatelessWidget {
  final Claim claim;

  const ClaimCard({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              claim.target,
              style: TextStyle(
                color: CustomColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              claim.explanation,
              style: TextStyle(color: CustomColors.primary),
            ),
            if (claim.url.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                "Bronnen:",
                style: TextStyle(
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...claim.url.map(
                (url) => LinkText(title: url, url: url)
              ),
            ],
          ],
        ),
      ),
    );
  }
}
