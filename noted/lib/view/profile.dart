import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  //temp
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
    );
  }
}
