import 'package:detective/features/history_drawer.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../features/header.dart';
import '../features/info_card.dart';
import '../features/underlined_title.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Column(
        children: [
          Header(title: "About"),
          Text(
            "How does detective work?",
            style: TextStyle(fontSize: Sizes.fontSizeTitle, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(64),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.spaceBetweenSections),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                        color: CustomColors.quaternary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UnderlinedTitle(title: "Medium length feature headline"), //TODO: Replace with real headline
                          const SizedBox(height: 32),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: Sizes.spaceBetweenSections),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.spaceBetweenSections),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                        color: CustomColors.quaternary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoCard(
                              icon: Icons.language,
                              title: "Medium Length Headline", //TODO: Replace with real headline
                              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                          ),
                          const SizedBox(height: Sizes.spaceBetweenSections),
                          InfoCard(
                              icon: Icons.autorenew,
                              title: "Medium Length Headline", //TODO: Replace with real headline
                              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                          ),
                          const SizedBox(height: Sizes.spaceBetweenSections),
                          InfoCard(
                              icon: Icons.star_rate,
                              title: "Medium Length Headline", //TODO: Replace with real headline
                              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            color: CustomColors.primary,
            alignment: Alignment.center,
            child: Text(
              "Factcheck Yourself",
              style: TextStyle(fontSize: Sizes.fontSizeTitle, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
