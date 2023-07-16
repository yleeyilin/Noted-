import 'package:flutter/material.dart';
import 'package:noted/controller/authController.dart';
import 'package:noted/controller/commentController.dart';
import 'package:noted/model/neo4j/retrieve.dart';
import 'package:noted/view/constant/colors.dart';

class NotesComment extends StatefulWidget {
  final String address;

  const NotesComment({Key? key, required this.address}) : super(key: key);

  @override
  State<NotesComment> createState() {
    return _NotesCommentState();
  }
}

class _NotesCommentState extends State<NotesComment> {
  final TextEditingController _textCon = TextEditingController();
  final CommentController _commentCon = CommentController();
  final AuthController _authCon = AuthController();

  List<dynamic>? comments = [];

  @override
  void initState() {
    super.initState();
    fetchCommentsAsync();
  }

  Future<void> fetchCommentsAsync() async {
    List<dynamic>? fetchedComments = await fetchComments(widget.address);
    if (fetchedComments != null) {
      setState(() {
        print("here");
        print(fetchedComments);
        comments = fetchedComments.cast<String>();
      });
    }
  }

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
              controller: _textCon,
              decoration: const InputDecoration(
                hintText: 'Enter your comment',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String commentText = _textCon.text;
                _commentCon.commentNode(
                  commentText,
                  _authCon.retrieveEmail()!,
                  widget.address,
                );
                setState(() {
                  comments?.add(commentText);
                  _textCon.clear();
                });
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
            Expanded(
              child: ListView.builder(
                itemCount: comments?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(comments![index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
