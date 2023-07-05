import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/model/neo4j/createNode.dart';

class Comment extends StatefulWidget {
  const Comment(
      {Key? key, required String articleId, required String articleAddress});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Enter your comment',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String commentText = _commentController.text;
                createCommentNode(commentText);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 9, 82),
              ),
              child: const Text('Submit'),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "All Comments",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
