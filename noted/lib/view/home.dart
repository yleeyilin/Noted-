import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/controller/articleController.dart';

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
  final ArticleController _con = ArticleController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _con.fetchAllArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            dynamic data = snapshot.data;
            articles = List<Map<String, dynamic>>.from(data);
            allArticles = List<Map<String, dynamic>>.from(data);
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
                            articles =
                                List<Map<String, dynamic>>.from(allArticles);
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
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                                    _con.viewPDF(article['address'], context);
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.comment,
                                      color: primary,
                                    ),
                                    onPressed: () {
                                      _con.openCommentScreen(context);
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
        });
  }
}
