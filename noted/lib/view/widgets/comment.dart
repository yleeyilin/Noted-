import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Add Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your comment',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //returns to prev page
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 9, 82),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
