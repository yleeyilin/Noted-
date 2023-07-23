import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted/view/login/changepassword.dart';
import 'package:integration_test/integration_test.dart';
import 'package:noted/view/login/login.dart';
import 'package:noted/view/profile.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Profile widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Profile(),
    ));

    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Reputation Score'), findsOneWidget);

    final changePasswordButton = find.text('CHANGE PASSWORD');
    expect(changePasswordButton, findsOneWidget);

    final cancelButton = find.text('CANCEL');
    expect(cancelButton, findsOneWidget);

    final saveButton = find.text('SAVE');
    expect(saveButton, findsOneWidget);

    final signOutButton = find.text('SIGN OUT');
    expect(signOutButton, findsOneWidget);

    await tester.tap(changePasswordButton);
    await tester.pumpAndSettle();

    expect(find.byType(ChangePassword), findsOneWidget);

    Navigator.pop(tester.element(find.byType(ChangePassword)));

    await tester.tap(signOutButton);
    await tester.pumpAndSettle();

    expect(find.byType(Login), findsOneWidget);
  });
}
