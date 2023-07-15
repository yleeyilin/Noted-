import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/neo4j/createRelationship.dart';
import 'package:noted/model/query/nusmods.dart';
import 'package:noted/model/neo4j/retrieve.dart';
import 'package:noted/model/query/pdfviewerscreen.dart';
import 'package:noted/view/widgets/comment.dart';
import 'package:noted/model/neo4j/updateNode.dart';

class CourseController extends ControllerMVC {
  factory CourseController() => _this ??= CourseController._();
  CourseController._();
  static CourseController? _this;

  Future<List<String>> fetchModuleCodes() async {
    return fetchNUSMODS();
  }

  Future<List?> retrieveAllNotes(String course) {
    return fetchNotes(course);
  }

  void searchNotes(String query, List<Map<String, dynamic>> filteredNotes,
      List<Map<String, dynamic>> searchResults) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = filteredNotes
            .where((note) => note['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        searchResults = List<Map<String, dynamic>>.from(filteredNotes);
      }
    });
  }

  void viewPDF(String pdfUrl, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
      ),
    );
  }

  void openCommentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Comment(
          articleId: '',
          articleAddress: '',
        ),
      ),
    );
  }

  Future<List?> fetchLikedNotes(String name) {
    return likedNotes(name);
  }

  void likeNote(String email, String articleAddress) async {
    await connectUserToNote(email, articleAddress);
  }

  void dislikeNote(String email, String articleAddress) async {
    await disconnectUserFromNote(email, articleAddress);
  }

//change
  void updateLikesNotes(String address, int likeCount) async {
    updateLikeCountNotes(address, likeCount);
  }

  Future<int?> getLikeCountNotes(String address) async {
    return likeCountNotes(address);
  }
}
