import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Note: Ensure this import matches the actual package name configured in your pubspec.yaml.
// If your package is named 'support_desk_pro', use:
// import 'package:support_desk_pro/main.dart';
import 'package:support_desk_pro/main.dart';

void main() {
  testWidgets('SupportDesk Pro Splash Screen load verification test', (WidgetTester tester) async {
    // Build the SupportDesk Pro application and trigger a frame.
    await tester.pumpWidget(const SupportDeskApp());

    // Verify that the application branding text is present on the splash screen.
    expect(find.text('SupportDesk Pro'), findsOneWidget);
    expect(find.text('Technical Support & Ticketing Suite'), findsOneWidget);

    // Verify that the support agent icon is loaded in the layout.
    expect(find.byIcon(Icons.support_agent), findsOneWidget);

    // Verify that the standard counter-app elements are not present.
    expect(find.text('0'), findsNothing);
    expect(find.byIcon(Icons.add), findsNothing);
  });
}