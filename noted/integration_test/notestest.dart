import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted/view/comment/notesComment.dart';
import 'package:noted/view/course/notes.dart';
import 'package:noted/view/widgets/generalsearchbar.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Notes widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Notes(courseCode: 'CS1231S'), 
    ));

    expect(find.byType(Notes), findsOneWidget);

    expect(find.text('Notes For CS1231S'), findsOneWidget);

    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    final notesList = find.byType(ListView);
    expect(notesList, findsOneWidget);

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.byType(NotesComment), findsOneWidget);

    Navigator.pop(tester.element(find.byType(NotesComment)));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.byType(GeneralSearchBar), findsOneWidget);
  });
}
