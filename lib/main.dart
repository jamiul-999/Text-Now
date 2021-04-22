import 'package:flutter/material.dart';
import 'package:text_now/pages/ConversationPageList.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: ConversationPageList(),
    );
  }
}
