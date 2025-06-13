import 'package:flutter/material.dart';

import '../features/underlined_title.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: CustomColors.primary, size: Sizes.iconSize),
        const SizedBox(width: Sizes.spaceBetweenSections),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UnderlinedTitle(title: title),
              const SizedBox(height: 8),
              Text(
                description,
                maxLines: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}