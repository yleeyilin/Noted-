import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/view/post/postNotes.dart';
import 'package:noted/widgets/generalsearchbar.dart';
import 'package:file_picker/file_picker.dart';

//index 1
class PostArticles extends StatefulWidget {
  const PostArticles({Key? key}) : super(key: key);

  @override
  State<PostArticles> createState() => _PostArticlesState();
}

class _PostArticlesState extends State<PostArticles> {
  late String pdfPath;
  int _selectedIndex = 1;

  Future<void> selectPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          pdfPath = result.files.single.path!;
        });
      }
    } catch (e) {
      // Handle any errors that occur during file picking.
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/logo-darkblue.png',
              width: 40,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              isSelected: [
                _selectedIndex == 0,
                _selectedIndex == 1,
              ],
              onPressed: (int index) {
                setState(() {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostNotes()),
                    );
                  }
                });
              },
              children: const [
                Text('Notes'),
                Text('Articles'),
              ],
            ),
            Text(
              'PDF Selected: $pdfPath',
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: selectPDF,
              child: const Text('Select PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
