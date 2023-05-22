import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/model/coursedata.dart';

//to link data from database

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //list that we are going to display and filter
  List<CourseData> display_list = List.from(main_course_list);

  //list of courses
  static List<CourseData> main_course_list = [];

  //function that will filter the list
  void updateList(String value) {
    setState(() {
      display_list = main_course_list
          .where(
            (element) => element.course!.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      //searchbar
      body: Column(
        children: [
          TextField(
            onChanged: (value) => updateList(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: primary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: display_list.length == 0
                ? const Center(
                    child: Text(
                      "No Results Found",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: display_list.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        display_list[index].course!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
