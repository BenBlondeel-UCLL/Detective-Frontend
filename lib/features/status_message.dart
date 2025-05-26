import 'package:flutter/material.dart';

class StatusMessage extends StatelessWidget{
  final bool state;
  final String text;
  const StatusMessage({super.key, required this.state, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: state ?Colors.green : Colors.red),
          Text(text, style: TextStyle(color: state ?Colors.green : Colors.red),), 
        ],
      ),
    );
  }
}
