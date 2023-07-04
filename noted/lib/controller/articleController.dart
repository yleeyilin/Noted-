import 'package:flutter/material.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/neo4j/retrieve.dart';
import 'package:noted/model/query/pdfviewerscreen.dart';
import 'package:noted/view/widgets/comment.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:noted/model/neo4j/updateNode.dart';
//import 'package:noted/main.dart';

class ArticleController extends ControllerMVC {
  factory ArticleController() => _this ??= ArticleController._();
  ArticleController._();
  static ArticleController? _this;

  dynamic fetchAllArticles() {
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

  void openCommentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Comment(),
      ),
    );
  }

  void updateLikeCount(String noteId, int newLikeCount) {
    return updateLikeCount(noteId, newLikeCount);
  }
}
