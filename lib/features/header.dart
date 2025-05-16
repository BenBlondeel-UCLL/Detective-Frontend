import 'package:detective/constants/colors.dart';
import 'package:detective/constants/sizes.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xFF001f34),
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              alignment: FractionalOffset.centerLeft,
              onPressed: () { Navigator.pushNamed(context, '/'); },
              icon: const Icon(Icons.home, color: CustomColors.secondary),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, color: CustomColors.secondary),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () { Navigator.pushNamed(context, '/login'); },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.buttonColor,
                foregroundColor: CustomColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.buttonRadius),
                ),
              ),
              child: const Text('Login', style: TextStyle(color: CustomColors.secondary)),
            ),
          ],
        ),
      ),
    );
  }
}
