import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/widgets/generalsearchbar.dart';
import 'package:noted/view/widgets/skeleton.dart';
import 'package:noted/controller/postController.dart';
import 'package:file_picker/file_picker.dart';

//index 1
class PostArticles extends StatefulWidget {
  const PostArticles({Key? key}) : super(key: key);

  @override
  State<PostArticles> createState() => _PostArticlesState();
}

class _PostArticlesState extends State<PostArticles> {
  TextEditingController titleController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  final int _selectedIndex = 1;
  late String pdfPath = '';
  final PostController _con = PostController();
  bool isFieldCompleted = false;
  bool isPdfSelected = false;
  late FilePickerResult res;

  Future<void> selectPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        pdfPath = result.files.single.path!;
        _con.fileName = result.files.single.name;
      });
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
                  _con.navigate(index, context);
                });
              },
              children: const [
                Text('Notes'),
                Text('Articles'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'PDF Selected: ${_con.fileName.isNotEmpty ? _con.fileName : "No PDF selected"}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (titleController.text.trim().isNotEmpty &&
                      summaryController.text.trim().isNotEmpty) {
                    isFieldCompleted = true;
                  }
                  isFieldCompleted = false;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: summaryController,
                decoration: const InputDecoration(
                  labelText: 'Summary',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (titleController.text.trim().isNotEmpty &&
                      summaryController.text.trim().isNotEmpty) {
                    isFieldCompleted = true;
                  }
                  isFieldCompleted = false;
                },
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
              onPressed: () async {
                res = (await _con.pickFile())!;
                setState(() {
                  isPdfSelected = true;
                });
              },
              child: const Text('Select PDF'),
            ),
            Visibility(
              visible: isFieldCompleted && isPdfSelected,
              child: ElevatedButton(
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
                onPressed: () {
                  _con.articleUpload(res, titleController.text, summaryController.text);
                },
                child: const Text('Confirm Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
