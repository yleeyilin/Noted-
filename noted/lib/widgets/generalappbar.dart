import 'package:flutter/material.dart';
import 'package:noted/view/searchbar/generalsearchbar.dart';
import 'package:noted/model/colors.dart';

class GeneralAppBar extends StatelessWidget {
  const GeneralAppBar({super.key});

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
        //general search bar
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: GeneralSearchBar(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
        backgroundColor: primary,
      ),
    );
  }
}
