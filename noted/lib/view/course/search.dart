import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/course/notes.dart';
import 'package:noted/controller/courseController.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isEmpty = true;

  bool isSearchBarEmpty(String value) {
    return value.trim().isEmpty;
  }

  List<String> displayList = [];
  Future<List<String>>? _moduleCodes;

  final CourseController _con = CourseController();

  @override
  void initState() {
    super.initState();
    _moduleCodes = _con.fetchModuleCodes();
  }

  void updateList(String value) {
    setState(() {
      _moduleCodes!.then((moduleCodes) {
        setState(() {
          displayList = moduleCodes
              .where((moduleCode) =>
                  moduleCode.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          //course search bar
          SizedBox(
            height: 60,
            child: TextField(
              onChanged: (value) {
                isEmpty = isSearchBarEmpty(value);
                updateList(value);
              },
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
          Expanded(
            child: Scrollbar(
              child: FutureBuilder<List<String>>(
                future: _moduleCodes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final moduleCodes = snapshot.data!;
                    final filteredList =
                        displayList.isNotEmpty ? displayList : moduleCodes;

                    if (filteredList == moduleCodes && !isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No Results Found',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 9, 9, 82),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final moduleCode = filteredList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 70,
                                ),
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Notes(),
                                  ),
                                );
                              },
                              child: Text(moduleCode),
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
