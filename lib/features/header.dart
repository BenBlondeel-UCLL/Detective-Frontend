import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    final storage = FlutterSecureStorage();

    return FutureBuilder<String?>(
      future: storage.read(key: 'jwt'),
      builder: (context, snapshot) {
        final jwt = snapshot.data;
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
                  icon: const Icon(Icons.home_outlined, color: Color(0xffE6F2F5)),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 20, color: Color(0xffE6F2F5)),
                    ),
                  ),
                ),
                (jwt == null)
                    ? ElevatedButton(
                        onPressed: () { Navigator.pushNamed(context, '/login'); },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00a2d4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        child: const Text('Login', style: TextStyle(color: Color(0xffE6F2F5))),
                      )
                    : ElevatedButton(
                        onPressed: () { 
                          Navigator.pushNamed(context, '/');
                          storage.delete(key: 'jwt');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00a2d4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        child: const Text('Logout', style: TextStyle(color: Color(0xffE6F2F5))),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
