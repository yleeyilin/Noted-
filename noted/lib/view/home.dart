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
  List<Map<String, dynamic>>? articles;
  List<Map<String, dynamic>>? allArticles;
  List<Map<String, dynamic>> likedArticles = [];
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
          articles ??= [];
          allArticles ??= [];
          likedArticles ??= []; // Initialize likedArticles as an empty list
          if (data != null) {
            articles = List<Map<String, dynamic>>.from(data);
            allArticles = List<Map<String, dynamic>>.from(data);
          }
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
                              List<Map<String, dynamic>>.from(allArticles!);
                        } else {
                          articles = allArticles!
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
                  child: articles!.isEmpty
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
                          itemCount: articles!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final article = articles![index];
                            final isLiked = likedArticles.any((likedArticle) =>
                                likedArticle['id'] == article['id']);
                            final likeCount =
                                article['like'] ?? 0; // Like count
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(article['title'] as String),
                                subtitle: Text(article['summary'] as String),
                                onTap: () {
                                  if (article['address'] != null) {
                                    _con.viewPDF(
                                        article['address'] as String, context);
                                  }
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: primary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (isLiked) {
                                            likedArticles.removeWhere(
                                                (likedArticle) =>
                                                    likedArticle['id'] ==
                                                    article['id']);
                                            if (article['id'] != null) {
                                              _con.updateLikeCount(
                                                  article['id'] as String,
                                                  likeCount - 1);
                                            }
                                          } else {
                                            likedArticles.add(article);
                                            if (article['id'] != null) {
                                              _con.updateLikeCount(
                                                  article['id'] as String,
                                                  likeCount + 1);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '$likeCount',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.comment,
                                        color: primary,
                                      ),
                                      onPressed: () {
                                        _con.openCommentScreen(context);
                                      },
                                    ),
                                  ],
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
      },
    );
  }
}
