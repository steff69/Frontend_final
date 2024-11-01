import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:travel_app/pages/welcome_page.dart';
import 'package:travel_app/pages/MainScreen.dart';
import 'package:travel_app/controller/testControl.dart'; // Ensure this path is correct

void main() {
  setUp(() {
    Get.put(TetyController());
  });

  tearDown(() {
    Get.delete<TetyController>();
  });

  testWidgets('WelcomePage displays elements and navigates on button tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: WelcomePage(),
      ),
    );

    expect(find.text("Welcome to \nTunisair Mobile"), findsOneWidget);
    expect(
      find.text(
        "Your gateway to seamless travel and exclusive Fidelys benefits right at your fingertips.",
      ),
      findsOneWidget,
    );

    final getStartedButton = find.text("Get Started");
    expect(getStartedButton, findsOneWidget);

    await tester.tap(getStartedButton);
    await tester.pumpAndSettle(); 
    expect(find.byType(MainScreen), findsOneWidget);
  });

}
