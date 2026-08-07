import 'package:eyan_app/features/my_app/my_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots to the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Eyan'), findsOneWidget);
  });
}
