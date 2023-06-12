import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/post/postNotes.dart';
import 'package:noted/controller/courseController.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
                child: FutureBuilder<List<String>>(
                    future: _moduleCodes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final moduleCodes = snapshot.data!;
                        final filteredList =
                            displayList.isNotEmpty ? displayList : moduleCodes;
                        return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final moduleCode = filteredList[index];
                            return ListTile(
                              title: Text(moduleCode),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      return const Center(
                        child: Text(
                          'No Results Found',
                          style: TextStyle(
                            color: Color.fromARGB(255, 9, 9, 82),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
              )
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
