import 'package:detective/api/http_client.dart';
import 'package:detective/pages/about.dart';
import 'package:detective/pages/redirect.dart';
import 'package:detective/pages/result_page.dart';
import 'package:detective/pages/login.dart';
import 'package:detective/pages/signup.dart';
import 'package:detective/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main({HttpClient? httpClient}) async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(httpClient: httpClient));
}

class MyApp extends StatelessWidget {
  final HttpClient? httpClient;
  const MyApp({super.key, this.httpClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detective',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: const Color(0xffE6F2F5),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name!.startsWith('/redirect')) {
          final uri = Uri.parse(settings.name!);
          final accessToken = uri.queryParameters['access_token'];
          final username = uri.queryParameters['username'];
          return MaterialPageRoute(
            builder: (_) =>
                RedirectPage(
                  accessToken: accessToken,
                  username: username,
                ),
            settings: settings,
          );
        }

        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => Home());
          case '/result':
            return MaterialPageRoute(builder: (_) => ResultPage());
          case '/about':
            return MaterialPageRoute(builder: (_) => const About());
          case '/login':
            return MaterialPageRoute(builder: (_) => Login());
          case '/signup':
            return MaterialPageRoute(builder: (_) => Signup(httpClient: httpClient));
          default:
            return MaterialPageRoute(builder: (_) => Home());
        }
      },
      // routes: {
      //   '/': (context) => Home(),
      //   '/result': (context) => ResultPage(),
      //   '/about': (context) => const About(),
      //   '/login': (context) => Login(),
      //   '/signup': (context) => Signup(),
      //   '/redirect': (context) => RedirectPage(),
      // },
      debugShowCheckedModeBanner: false,
    );
  }
}