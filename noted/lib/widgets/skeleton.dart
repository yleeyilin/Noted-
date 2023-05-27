import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/view/chat/suggestedChat.dart';
import 'package:noted/view/search.dart';
import 'package:noted/view/profile.dart';
import 'package:noted/view/home.dart';
import 'package:noted/widgets/generalsearchbar.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  //navigation
  List<Widget> navigationFunction = [
    const Home(),
    const Search(),
    const SuggestedChat(),
    const Profile(),
  ];

  //index for bottom navigation bar
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationFunction[_currentIndex],
      backgroundColor: primary,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: primary,
              icon: const Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              backgroundColor: primary,
              icon: const Icon(
                Icons.search,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              backgroundColor: primary,
              icon: const Icon(
                Icons.chat,
              ),
              label: 'Chat'),
          BottomNavigationBarItem(
              backgroundColor: primary,
              icon: const Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
