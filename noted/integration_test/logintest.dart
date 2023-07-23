import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:noted/view/login/login.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Login(),
    ));

    final signUpButton = find.text('Sign Up');
    final signInButton = find.text('Sign In');

    expect(signUpButton, findsOneWidget);
    expect(signInButton, findsOneWidget);

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();
    expect(find.text('SignUp'), findsOneWidget);

    Navigator.pop(tester.element(find.text('SignUp')));

    await tester.tap(signInButton);
    await tester.pumpAndSettle();
    expect(find.text('SignIn'), findsOneWidget);
  });
}
