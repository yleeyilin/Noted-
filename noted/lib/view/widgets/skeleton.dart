import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/post.dart';
import 'package:noted/view/search.dart';
import 'package:noted/view/profile.dart';
import 'package:noted/view/home.dart';
import 'package:noted/view/widgets/generalsearchbar.dart';

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
    const Post(),
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Skeleton(),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/logo-darkblue.png',
                width: 40,
              ),
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
                Icons.post_add,
              ),
              label: 'Post'),
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
