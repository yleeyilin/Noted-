import 'package:flutter/material.dart';
import 'package:noted/controller/authController.dart';
import 'package:noted/view/comment/notesComment.dart';
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
  List<String> likedNotes = [];
  final CourseController _con = CourseController();
  final AuthController _authCon = AuthController();
  var likeIcons = <int, Icon>{};

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
        // General search bar
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
      body: Column(
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
                      final noteAddress = note['address'];
                      var noteLikeCount = note['likeCount'];
                      print(noteLikeCount);
                      final isLiked = likedNotes.contains(noteAddress);
                      if (!likeIcons.containsKey(index)) {
                        likeIcons[index] = isLiked
                            ? Icon(
                                Icons.favorite,
                                color: primary,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: primary,
                              );
                      }

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
                                  IconButton(
                                    icon: likeIcons[index]!,
                                    onPressed: () {
                                      final isNoteLiked =
                                          likedNotes.contains(noteAddress);
                                      // Toggle like relationship
                                      if (isNoteLiked) {
                                        // Dislike relationship
                                        String? email =
                                            _authCon.retrieveEmail();
                                        _con.dislikeNote(email!, noteAddress);

                                        // Decrement like count
                                        if (noteLikeCount != null) {
                                          //print(noteAddress);
                                          _con.updateLikesNotes(
                                              noteAddress, noteLikeCount - 1);
                                        }

                                        // Update likedArticles list
                                        setState(() {
                                          likedNotes.remove(noteAddress);
                                        });

                                        // Change icon
                                        setState(() {
                                          likeIcons[index] = Icon(
                                            Icons.favorite_border,
                                            color: primary,
                                          );
                                        });
                                      } else {
                                        // Like relationship
                                        String? email =
                                            _authCon.retrieveEmail();
                                        _con.likeNote(email!, noteAddress);

                                        // Increment like count
                                        if (noteLikeCount != null) {
                                          _con.updateLikesNotes(
                                              noteAddress, noteLikeCount + 1);
                                        } else {
                                          _con.updateLikesNotes(noteAddress, 1);
                                        }

                                        // Update likedArticles list
                                        setState(() {
                                          likedNotes.add(noteAddress);
                                        });

                                        // Change icon
                                        setState(() {
                                          likeIcons[index] = Icon(
                                            Icons.favorite,
                                            color: primary,
                                          );
                                        });
                                      }
                                    },
                                  ),
                                  FutureBuilder(
                                    future: _con.getLikeCountNotes(noteAddress),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Object? likeCount = snapshot.data;
                                        return Text(
                                          likeCount.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.comment,
                                      color: primary,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NotesComment(
                                              address: noteAddress),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
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
    );
  }
}
