import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:noted/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_async/fake_async.dart';


class MockGraphQLClient extends Mock implements GraphQLClient {}

class MockHttpLink extends Mock implements HttpLink {}
void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Mock the GraphQL client
    final client = ValueNotifier(MockGraphQLClient());

    // Build the widget
    await tester.pumpWidget(
      GraphQLProvider(
        client: client,
        child: const MyApp(),
      ),
    );

    // Wait for any asynchronous operations to complete
    await tester.pumpAndSettle();

    final fakeAsync = FakeAsync();
    fakeAsync.run((fakeAsync) {

      // Dispose of any pending timers
      fakeAsync.flushTimers();
    });

    // Verify the root widget
    expect(find.byType(AnimatedSplashScreen), findsOneWidget); // Ensure MaterialApp is present
    expect(find.byType(MaterialApp), findsOneWidget); // Ensure SplashScreen is present
  });
}
