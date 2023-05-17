import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';

//Ongoing

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            Image.asset(
              'assets/images/logo-darkblue.png',
              width: 40,
            ),
          ],
        ),
        backgroundColor: primary,
      ),
    );
  }
}
