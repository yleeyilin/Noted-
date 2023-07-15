import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/widgets/generalsearchbar.dart';
import 'package:noted/view/widgets/skeleton.dart';
import 'package:noted/controller/courseController.dart';

class Notes extends StatefulWidget {
  final String courseCode;

  const Notes({Key? key, required this.courseCode}) : super(key: key);

  @override
  State<Notes> createState() {
    return _NotesState();
  }
}

class _NotesState extends State<Notes> {
  late List<Map<String, dynamic>> filteredNotes = [];
  late List<Map<String, dynamic>> searchResults = [];
  final CourseController _con = CourseController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _con.retrieveAllNotes(widget.courseCode).then((notesData) {
        setState(() {
          filteredNotes = List<Map<String, dynamic>>.from(notesData!);
          searchResults = List<Map<String, dynamic>>.from(notesData);
        });
      }).catchError((error) {
        print('Error: $error');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Notes For ${widget.courseCode}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 9, 9, 82),
              ),
            ),
            const SizedBox(height: 20),
            // Notes search bar
            SizedBox(
              height: 60,
              child: TextField(
                onChanged: (value) =>
                    _con.searchNotes(value, filteredNotes, searchResults),
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
              child: searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final note = searchResults[index];
                        var likeCount = note['like'] ?? 0;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 24,
                              ),
                              minimumSize: const Size(double.infinity, 48),
                              backgroundColor: Colors.white,
                              foregroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: primary),
                              ),
                            ),
                            onPressed: () {
                              _con.viewPDF(note['address'], context);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    note['name'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 9, 9, 82),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: primary,
                                    ),
                                    Text(
                                      '$likeCount',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    //edit
                                  },
                                  icon: Icon(
                                    Icons.comment,
                                    color: primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Results Found',
                        style: TextStyle(
                          color: Color.fromARGB(255, 9, 9, 82),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
