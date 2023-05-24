import 'package:flutter/material.dart';
import 'package:noted/view/chat/chatsPage.dart';
import 'package:noted/view/chat/suggestedChat.dart';


class ChatController extends StatelessWidget {
  ChatController({Key? key}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(controller: _pageController, 
        children: const [
          SuggestedChat(),
          ChatsPage(),
          ]
        )
    );
  }
}