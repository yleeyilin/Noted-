import 'package:flutter/material.dart';
import 'package:noted/controller/courseController.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/widgets/generalsearchbar.dart';
import 'package:noted/view/widgets/skeleton.dart';
import 'package:noted/controller/postController.dart';
import 'package:dropdown_search/dropdown_search.dart';


class PostNotes extends StatefulWidget {
  const PostNotes({Key? key}) : super(key: key);

  @override
  State<PostNotes> createState() => _PostNotesState();
}

class _PostNotesState extends State<PostNotes> {
  final int _selectedIndex = 0;
  final PostController _postCon = PostController();
  final CourseController _courseCon = CourseController();
  bool isEmpty = true;

  bool isSearchBarEmpty(String value) {
    return value.trim().isEmpty;
  }

  List<String> displayList = [];
  Future<List<String>>? _moduleCodes;
  String? selectedModuleCode;

  void updateList(String value) {
    setState(() {
      _moduleCodes!.then((moduleCodes) {
        setState(() {
          displayList = moduleCodes
              .where((moduleCode) =>
                  moduleCode.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadModuleCodes();
  }

  Future<void> _loadModuleCodes() async {
    List<String> moduleCodes = await _courseCon.fetchModuleCodes();
    setState(() {
      _moduleCodes = Future.value(moduleCodes);
    });
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
        // general search bar
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
                  _postCon.navigate(index, context);
                });
              },
              children: const [
                Text('Notes'),
                Text('Articles'),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<String>>(
              future: _moduleCodes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator while fetching module codes
                } else if (snapshot.hasError) {
                  return const Text('Error loading module codes'); // Display an error message if fetching fails
                } else {
                  List<String>? moduleCodes = snapshot.data;
                  if (moduleCodes == null || moduleCodes.isEmpty) {
                    return const Text('No module codes available'); // Display a message if no module codes are found
                  }
                  return DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: moduleCodes,
                    onChanged: (selectedItem) {
                      setState(() {
                        selectedModuleCode = selectedItem;
                      });
                    },
                    selectedItem: selectedModuleCode,
                    dropdownSearchDecoration: const InputDecoration(
                      labelText: "Search Course",
                      contentPadding: EdgeInsets.all(10),
                    ),
                    showSearchBox: true,
                    searchFieldProps: const TextFieldProps(
                      decoration: InputDecoration(
                        hintText: "Search",
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'PDF Selected: ${_postCon.fileName.isNotEmpty ? _postCon.fileName : "No PDF selected"}',
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
              onPressed: _postCon.pickNotesFile,
              child: const Text('Select PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
