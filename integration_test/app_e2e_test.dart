import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:critify/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import '../test/mocks.mocks.dart';
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Sign Up Flow with Mockito', (WidgetTester tester) async {
    final mockHttpClient = MockHttpClient();

    when(
      mockHttpClient.postSignUp(username: anyNamed('username'), email: anyNamed('email'), password: anyNamed('password')),
    ).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: '/auth/signup'),
      statusCode: 200,
      data: {'message': 'Signup successful'},
    ));

    app.main(httpClient: mockHttpClient);
    await tester.pumpAndSettle();

    // Logout if already logged in
    final logoutButton = find.byKey(const Key('logoutButton'));
    if (logoutButton.evaluate().isNotEmpty) {
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();
      final logoutConfirmationButton = find.byKey(
        const Key('logoutConfirmationButton'),
      );
      if (logoutConfirmationButton.evaluate().isNotEmpty) {
        await tester.tap(logoutConfirmationButton);
        await tester.pumpAndSettle();
      }
    }

    // Navigate to login page if needed
    final goToLoginPageButton = find.byKey(const Key('goToLoginPageButton'));
    if (goToLoginPageButton.evaluate().isNotEmpty) {
      await tester.tap(goToLoginPageButton);
      await tester.pumpAndSettle();
    }

    // Navigate to login page if needed
    final goToSignupPageButton = find.byKey(const Key('goToSignUpPageButton'));
    if (goToSignupPageButton.evaluate().isNotEmpty) {
      await tester.tap(goToSignupPageButton);
      await tester.pumpAndSettle();
    }

    await tester.enterText(
      find.byKey(const Key('signUpUsernameField')),
      'testuser',
    );
    await tester.enterText(
      find.byKey(const Key('signUpEmailField')),
      'testuser@gmail.com',
    );
    await tester.enterText(
      find.byKey(const Key('signUpPasswordField')),
      '123',
    );
    await tester.enterText(
      find.byKey(const Key('signUpPasswordRepeatField')),
      '123',
    );
    await tester.tap(find.byKey(const Key('signUpButton')));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Account aangemaakt', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Login Flow', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Logout if already logged in
    final logoutButton = find.byKey(const Key('logoutButton'));
    if (logoutButton.evaluate().isNotEmpty) {
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();
      final logoutConfirmationButton = find.byKey(
        const Key('logoutConfirmationButton'),
      );
      if (logoutConfirmationButton.evaluate().isNotEmpty) {
        await tester.tap(logoutConfirmationButton);
        await tester.pumpAndSettle();
      }
    }

    // Navigate to login page if needed
    final goToLoginPageButton = find.byKey(const Key('goToLoginPageButton'));
    if (goToLoginPageButton.evaluate().isNotEmpty) {
      await tester.tap(goToLoginPageButton);
      await tester.pumpAndSettle();
    }

    await tester.enterText(
      find.byKey(const Key('loginEmailField')),
      'testuser@gmail.com',
    );
    await tester.enterText(find.byKey(const Key('loginPasswordField')), '123');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('succesvol aangemeld', skipOffstage: false), findsOneWidget);
  });
}
