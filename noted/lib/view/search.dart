import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    //temporary
    return Scaffold(
      backgroundColor: primary,
    );
  }
}
