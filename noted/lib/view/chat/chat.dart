import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';

class Chat extends StatefulWidget {
  final String currentUserEmail;
  final String otherUserEmail;

  const Chat({
    Key? key,
    required this.currentUserEmail,
    required this.otherUserEmail,
  }) : super(key: key);
  
  @override
  State<Chat> createState() => _ChatState();
}


class _ChatState extends State<Chat> {
  final String otherEmail = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
    );
  }
}
