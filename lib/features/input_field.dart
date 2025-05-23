import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;

  const InputField({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.multiline,
        minLines: 4,
        maxLines: 20,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Give your article',
        ),
      ),
    );
  }
}
