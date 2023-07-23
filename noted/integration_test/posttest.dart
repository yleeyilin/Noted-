import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted/view/post.dart';
import 'package:noted/view/post/postArticles.dart';
import 'package:noted/view/post/postNotes.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Post widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Post(),
    ));

    final postArticlesButton = find.text('Post Articles');
    expect(postArticlesButton, findsOneWidget);

    final postNotesButton = find.text('Post Notes');
    expect(postNotesButton, findsOneWidget);

    await tester.tap(postArticlesButton);
    await tester.pumpAndSettle();

    expect(find.byType(PostArticles), findsOneWidget);

    Navigator.pop(tester.element(find.byType(PostArticles)));

    await tester.tap(postNotesButton);
    await tester.pumpAndSettle();

    expect(find.byType(PostNotes), findsOneWidget);
  });

  testWidgets('PostArticles widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PostArticles(),
    ));

    expect(find.byType(PostArticles), findsOneWidget);

    expect(find.text('PDF Selected: No PDF selected'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Sample Title');
    await tester.enterText(find.byType(TextField).last, 'Sample Summary');
    await tester.pumpAndSettle();

    expect(find.text('Sample Title'), findsOneWidget);
    expect(find.text('Sample Summary'), findsOneWidget);

    await tester.tap(find.text('Select PDF'));
    await tester.pumpAndSettle();

    expect(find.text('PDF Selected: '), findsOneWidget);
    await tester.tap(find.text('Confirm Upload'));
    await tester.pumpAndSettle();
  });

  testWidgets('PostNotes widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PostNotes(),
    ));

    expect(find.byType(PostNotes), findsOneWidget);

    expect(find.text('PDF Selected: No PDF selected'), findsOneWidget);

    await tester.tap(find.text('Select PDF'));
    await tester.pumpAndSettle();

    expect(find.byType(DropdownSearch<String>), findsOneWidget);

    await tester.tap(find.byType(DropdownSearch<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Course 1').last);
    await tester.pumpAndSettle();

    expect(find.text('Course 1'), findsOneWidget);

    await tester.tap(find.text('Select PDF'));
    await tester.pumpAndSettle();

    expect(find.byType(DropdownSearch<String>), findsOneWidget);

    await tester.tap(find.byType(DropdownSearch<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Course 2').last);
    await tester.pumpAndSettle();

    expect(find.text('Course 2'), findsOneWidget);

    // Tap on the 'Select PDF' button again.
    await tester.tap(find.text('Select PDF'));
    await tester.pumpAndSettle();

    expect(find.byType(DropdownSearch<String>), findsOneWidget);

    // Tap on a course from the dropdown.
    await tester.tap(find.byType(DropdownSearch<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Course 3').last);
    await tester.pumpAndSettle();

    expect(find.text('Course 3'), findsOneWidget);

    await tester.tap(find.text('Select PDF'));
    await tester.pumpAndSettle();

    expect(find.byType(DropdownSearch<String>), findsOneWidget);

    await tester.tap(find.text('Confirm Upload'));
    await tester.pumpAndSettle();

  });
}
