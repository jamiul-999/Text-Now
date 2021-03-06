import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_now/pages/ConversationPage.dart';
import 'package:text_now/pages/ConversationPageSlide.dart';
import 'package:text_now/widgets/InputWidget.dart';

void main() {
  const MaterialApp app = MaterialApp(
    home: Scaffold(body: const ConversationPageSlide()),
  );
  testWidgets('ConversationPageSlide UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);
    expect(find.byType(ConversationPage), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(InputWidget), findsOneWidget);
  });
}
