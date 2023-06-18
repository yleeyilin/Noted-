import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';

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
        body: Column(
      children: [
        const SizedBox(height: 10),
        //article search bar
        SizedBox(
          height: 60,
          child: TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 9, 9, 82),
                ),
              ),
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: primary,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ));
  }
}
