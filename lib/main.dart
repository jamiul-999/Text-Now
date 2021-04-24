import 'package:flutter/material.dart';
import 'config/Palette.dart';
import 'pages/ConversationPageSlide.dart';
import 'pages/ConversationPage.dart';

void main() {
  runApp(TextNow());
}

class TextNow extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Now',
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      home: ConversationPageSlide(),
    );
  }
}
