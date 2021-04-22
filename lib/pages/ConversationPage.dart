import 'package:flutter/material.dart';
import 'package:text_now/config/Palette.dart';
import 'package:text_now/pages/ConversationBottomSheet.dart';
import 'package:text_now/widgets/ChatAppBar.dart';
import 'package:text_now/widgets/ChatListWidget.dart';
import 'package:text_now/widgets/InputWidget.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();

  const ConversationPage();
}

class _ConversationPageState extends State<ConversationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ChatAppBar(), // Custom app bar for chat screen
            body: Container(
                color: Palette.chatBackgroundColor,
                child: Stack(children: <Widget>[
                  Column(
                    children: <Widget>[
                      ChatListWidget(),
                      GestureDetector(
                          child: InputWidget(),
                          onPanUpdate: (details) {
                            if (details.delta.dy < 0) {
                              _scaffoldKey.currentState.showBottomSheet<Null>(
                                  (BuildContext context) {
                                return ConversationBottomSheet();
                              });
                            }
                          })
                    ],
                  ),
                ]))));
  }
}
