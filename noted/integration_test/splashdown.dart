import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:noted/main.dart';
import 'package:noted/view/login/splashscreen.dart';

void main() async{
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App starts with SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}