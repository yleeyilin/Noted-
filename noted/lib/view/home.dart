import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/post/postArticles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: const [
              SizedBox(height: 650),
              // Add your other ListView items here
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 8.0,
            child: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Material(
                  color: primary,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostArticles(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
