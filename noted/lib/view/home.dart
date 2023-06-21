import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/model/query/pdfviewerscreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  void viewPDF(String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
      ),
    );
  }

  // temp data
  final List<Map<String, String>> articleList = [
    {
      'title': 'Article 1',
      'summary': 'Summary of article 1',
    },
    {
      'title': 'Article 2',
      'summary': 'Summary of article 2',
    },
    {
      'title': 'Article 3',
      'summary': 'Summary of article 3',
    },
    {
      'title': 'Article 4',
      'summary': 'Summary of article 4',
    },
    {
      'title': 'Article 5',
      'summary': 'Summary of article 5',
    },
    {
      'title': 'Article 5',
      'summary': 'Summary of article 5',
    },
    {
      'title': 'Article 6',
      'summary': 'Summary of article 6',
    },
    {
      'title': 'Article 7',
      'summary': 'Summary of article 7',
    },
  ];

  List<Map<String, String>> filteredArticleList = [];

  @override
  void initState() {
    super.initState();
    filteredArticleList = List.from(articleList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          //code for article search
          SizedBox(
            height: 60,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filteredArticleList = articleList
                      .where((article) => article['title']!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 9, 9, 82),
                  ),
                ),
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredArticleList.isEmpty
                ? const Center(
                    child: Text(
                      'No Results Found',
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 9, 82),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredArticleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final article = filteredArticleList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            article['title']!,
                          ),
                          subtitle: Text(
                            article['summary']!,
                          ),
                          onTap: () {
                            // viewPDF(address);
                            // the address param should be replaced with the address property
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
