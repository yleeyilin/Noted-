import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    //temporary
    return Scaffold(
      backgroundColor: primary,
    );
  }
}
