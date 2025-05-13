import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
              child:
              IconButton(
                alignment: FractionalOffset.centerLeft,
                onPressed: () {},
                icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.grey
                ),
              ),
          ),
          const Expanded(
            flex: 1,
            child:
              Center(
                child: Text(
                  'Article Analyzer',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                  ),
                ),
             ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
              child:
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
          )
        ],
      ),
    );
  }
}