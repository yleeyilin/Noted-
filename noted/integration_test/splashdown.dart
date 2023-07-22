import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:noted/main.dart';
import 'package:noted/view/login/splashscreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App starts with SplashScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with the SplashScreen widget.
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}