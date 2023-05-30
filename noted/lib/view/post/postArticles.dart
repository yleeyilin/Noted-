import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/view/post/postNotes.dart';
import 'package:noted/widgets/generalsearchbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:noted/widgets/skeleton.dart';

//index 1
class PostArticles extends StatefulWidget {
  const PostArticles({Key? key}) : super(key: key);

  @override
  State<PostArticles> createState() => _PostArticlesState();
}

class _PostArticlesState extends State<PostArticles> {
  late String pdfPath = '';
  final int _selectedIndex = 1;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              constraints: const BoxConstraints(
                minWidth: 100,
                minHeight: 40,
              ),
              borderColor: primary,
              borderWidth: 2,
              borderRadius: BorderRadius.circular(10),
              selectedBorderColor: primary,
              selectedColor: Colors.white,
              color: primary,
              fillColor: primary,
              splashColor: const Color.fromARGB(255, 65, 65, 129),
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
            const SizedBox(height: 20),
            Text(
              'PDF Selected: $pdfPath',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 50,
                ),
                backgroundColor: primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: selectPDF,
              child: const Text('Select PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
