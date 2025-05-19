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
        color: CustomColors.primary,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: IconButton(
                alignment: FractionalOffset.centerLeft,
                onPressed: () { Navigator.pushNamed(context, '/'); },
                icon: const Icon(Icons.home, color: CustomColors.secondary, size: Sizes.iconSize),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: Sizes.fontSizeTitle, color: CustomColors.secondary),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, '/login'); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor,
                  foregroundColor: CustomColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.buttonRadius),
                  ),
                ),
                child: const Text('Login', style: TextStyle(color: CustomColors.secondary, fontSize: Sizes.fontSizeMedium)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
