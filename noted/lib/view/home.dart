import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/model/query/pdfviewerscreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';
import 'widgets/comment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> articles = [];
  List<Map<String, dynamic>> allArticles = [];

  void viewPDF(String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
      ),
    );
  }

  void openCommentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Comment(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final QueryOptions options = QueryOptions(
      document: gql('''
        query GetArticles {
          articles {
            title
            summary
            address
          }
        }
      '''),
    );

    final QueryResult result = await client.value.query(options);

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    } else {
      final dynamic data = result.data?['articles'];
      if (data != null) {
        setState(() {
          articles = List<Map<String, dynamic>>.from(data);
          allArticles = List<Map<String, dynamic>>.from(data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    articles = List<Map<String, dynamic>>.from(allArticles);
                  } else {
                    articles = allArticles
                        .where((article) => article['title']
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }
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
            child: articles.isEmpty
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
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final article = articles[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            article['title'] as String,
                          ),
                          subtitle: Text(
                            article['summary'] as String,
                          ),
                          onTap: () {
                            viewPDF(article['address']);
                          },
                          trailing: IconButton(
                            icon: Icon(
                              Icons.comment,
                              color: primary,
                            ),
                            onPressed: () {
                              openCommentScreen();
                            },
                          ),
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
