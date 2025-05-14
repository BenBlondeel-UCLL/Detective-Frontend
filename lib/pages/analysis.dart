import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Analysis",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.bar_chart,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 10,
                                          margin: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          color: Colors.grey[400],
                                        ),
                                        Container(
                                          height: 10,
                                          color: Colors.grey[400],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'sales of pencil cases rose by 17%',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              for (int i = 0; i < 12; i++)
                                Container(
                                  height: 8,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  width: double.infinity,
                                  color: Colors.grey[400],
                                ),
                              const SizedBox(height: 16),
                              const Text(
                                '"The pencil case is being reimagined," says Andrea Chen',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              for (int i = 0; i < 9; i++)
                                Container(
                                  height: 8,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  width: double.infinity,
                                  color: Colors.grey[400],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
