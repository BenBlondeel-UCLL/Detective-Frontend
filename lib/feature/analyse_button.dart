import 'package:flutter/material.dart';

class AnalyseButton extends StatelessWidget {
  const AnalyseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              )
            ),
            child: const Text('Analyse'),
          ),
        );
  }
}