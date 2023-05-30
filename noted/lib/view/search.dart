import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/model/coursedata.dart';
import 'package:noted/view/post/postNotes.dart';

//to link data from database

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //list that we are going to display and filter
  // ignore: non_constant_identifier_names
  List<CourseData> display_list = List.from(main_course_list);

  //list of courses
  // ignore: non_constant_identifier_names
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextField(
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
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: display_list.isEmpty
                    ? const Center(
                        child: Text(
                          "No Results Found",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
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
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 8.0,
            child: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    splashColor: primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostNotes(),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
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
