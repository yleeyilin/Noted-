import 'package:flutter/material.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/neo4j/retrieve.dart';
import 'package:noted/model/query/pdfviewerscreen.dart';
import 'package:noted/view/widgets/comment.dart';
import '../model/neo4j/createRelationship.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:noted/model/neo4j/updateNode.dart';
//import 'package:noted/main.dart';

class ArticleController extends ControllerMVC {
  factory ArticleController() => _this ??= ArticleController._();
  ArticleController._();
  static ArticleController? _this;

  Future<List?> fetchAllArticles() {
    return fetchArticles();
  }

  void viewPDF(String pdfUrl, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
      ),
    );
  }

  void openCommentScreen(BuildContext context, String article) {
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

  // void updateLikeCount(String noteId, int newLikeCount) {
  //   return updateLikeCount(noteId, newLikeCount);
  // }

  void likeArticle(String email) async {
    await connectUserToArticle(email);
  }

  void dislikeArticle(String email) async {
    await disconnectUserFromArticle(email);
  }
}
