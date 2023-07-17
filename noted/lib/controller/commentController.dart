//import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/neo4j/createNode.dart';
//import 'package:noted/main.dart';
import 'package:noted/model/neo4j/retrieve.dart';
import 'package:noted/model/neo4j/createRelationship.dart';

class CommentController extends ControllerMVC {
  factory CommentController() => _this ??= CommentController._();
  CommentController._();
  static CommentController? _this;

  //fetches all the comments for the particular note
  Future<List?> fetchAllComments(String address) {
    print("executed");
    return fetchComments(address);
  }

  // void commentByUser(String content, String email) async {
  //   await connectCommentToAuthor(content, email);
  // }

  // void commentOnNote(String content, String address) async {
  //   await connectCommentToNote(content, address);
  // }

  Future<void> commentNode(String content, String email, String address) async {
    await createCommentNode(content, address);
    await connectCommentToAuthor(content, email);
  }
}
