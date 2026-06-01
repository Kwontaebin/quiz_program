import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_program/app.dart';
import 'package:quiz_program/config/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Preferences.init();
  });

  testWidgets('Quiz program smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the selection screen is shown (assuming no quizNum is saved)
    expect(find.text('프로젝트 선택'), findsOneWidget);
  });
}
