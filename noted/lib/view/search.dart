import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/post/postNotes.dart';
import 'package:noted/model/query/retrievecourse.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> displayList = [];

  RetrieveCourse retrieveCourse = RetrieveCourse();

  @override
  void initState() {
    super.initState();
    retrieveCourse.getModuleCodes().then((moduleCodes) {
      setState(() {
        displayList = moduleCodes;
      });
    });
  }

  void updateList(String value) {
    setState(() {
      displayList = displayList
          .where((moduleCode) =>
              moduleCode.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: TextField(
                  onChanged: (value) => updateList(value),
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
                          color: Color.fromARGB(255, 9, 9, 82)),
                    ),
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: displayList.isEmpty
                    ? const Center(
                        child: Text(
                          'No Results Found',
                          style: TextStyle(
                            color: Color.fromARGB(255, 9, 9, 82),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: displayList.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            displayList[index],
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
                  color: primary,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostNotes(),
                        ),
                      );
                    },
                    child: const Icon(Icons.add, color: Colors.white),
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
