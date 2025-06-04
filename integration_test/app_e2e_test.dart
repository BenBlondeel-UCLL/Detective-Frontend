import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:detective/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Sign Up Flow', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Logout if already logged in
    final logoutButton = find.byKey(const Key('logoutButton'));
    if (logoutButton.evaluate().isNotEmpty) {
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();
      final logoutConfirmationButton = find.byKey(const Key('logoutConfirmationButton'));
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

    await tester.enterText(find.byKey(const Key('signUpUsernameField')), 'testuser');
    await tester.enterText(find.byKey(const Key('signUpEmailField')), 'testuser@gmail.com');
    await tester.enterText(find.byKey(const Key('signUpPasswordField')), '123');
    await tester.enterText(find.byKey(const Key('signUpPasswordRepeatField')), '123');
    await tester.tap(find.byKey(const Key('signUpButton')));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Created Account'), findsOneWidget);
  });

  testWidgets('Login Flow', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Logout if already logged in
    final logoutButton = find.byKey(const Key('logoutButton'));
    if (logoutButton.evaluate().isNotEmpty) {
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();
      final logoutConfirmationButton = find.byKey(const Key('logoutConfirmationButton'));
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

    await tester.enterText(find.byKey(const Key('loginEmailField')), 'testuser@gmail.com');
    await tester.enterText(find.byKey(const Key('loginPasswordField')), '123');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('succesfully logged in'), findsAny);
  });

  // testWidgets('History Fetch', (WidgetTester tester) async {
  //   app.main();
  //   await tester.pumpAndSettle();
  //
  //   // Assume user is already logged in or perform login steps here
  //   final historyTab = find.byKey(const Key('historyTab'));
  //   if (historyTab.evaluate().isNotEmpty) {
  //     await tester.tap(historyTab);
  //     await tester.pumpAndSettle();
  //   }
  //
  //   expect(find.byType(ListView), findsOneWidget);
  //   // Optionally check for a specific history item
  //   // expect(find.text('Expected History Item'), findsOneWidget);
  // });
}
