import 'package:detective/api/http_client.dart';
import 'package:detective/pages/about.dart';
import 'package:detective/pages/redirect.dart';
import 'package:detective/pages/result_page.dart';
import 'package:detective/pages/login.dart';
import 'package:detective/pages/signup.dart';
import 'package:detective/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Only import web packages when targeting web
import 'package:flutter_web_plugins/url_strategy.dart' if (dart.library.html) 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main({HttpClient? httpClient}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  runApp(MyApp(httpClient: httpClient));
}

class MyApp extends StatelessWidget {
  final HttpClient? httpClient;
  const MyApp({super.key, this.httpClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Critify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: const Color(0xffE6F2F5),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        print("name: ${settings.name}");

        // Handle both /redirect and /#/redirect patterns
        final redirectPattern = RegExp(r'^/?#?/redirect');
        if (settings.name != null && redirectPattern.hasMatch(settings.name!)) {
          final uri = Uri.parse(settings.name!);
          final accessToken = uri.queryParameters['access_token'];
          final username = uri.queryParameters['username'];
          return MaterialPageRoute(
            builder: (_) => RedirectPage(
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
      debugShowCheckedModeBanner: false,
    );
  }
}