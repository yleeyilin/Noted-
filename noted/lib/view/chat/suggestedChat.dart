import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';

class SuggestedChat extends StatefulWidget {
  const SuggestedChat({super.key});

  @override
  State<SuggestedChat> createState() {
    return _SuggestedChatState();
  }
}

class _SuggestedChatState extends State<SuggestedChat> {
  @override
  Widget build(BuildContext context) {
    //temporary
    return Scaffold(
      backgroundColor: primary,
    );
  }
}