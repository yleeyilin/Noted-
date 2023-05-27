import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
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
    //temporary
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          const SizedBox(
            height: 650,
          ),
          Row(
            children: [
              const SizedBox(
                width: 350,
              ),
              SizedBox.fromSize(
                size: const Size(50, 50),
                child: ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: primary,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PostArticles(),
                          ),
                        );
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
