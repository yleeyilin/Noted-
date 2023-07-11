import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/controller/articleController.dart';
import '../controller/authController.dart';
import 'package:noted/model/neo4j/retrieve.dart';

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
  final AuthController _authCon = AuthController();
  bool _isRefreshing = false;
  var likeIcon = Icon(
    Icons.favorite_border,
    color: primary,
  );

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });
    dynamic data = await _con.fetchAllArticles();
    setState(() {
      articles = List<Map<String, dynamic>>.from(data);
      allArticles = List<Map<String, dynamic>>.from(data);
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            return false;
          },
          child: _buildArticleList()),
    );
  }

  Widget _buildArticleList() {
    return FutureBuilder(
      future: _con.fetchAllArticles(),
      builder: (context, snapshot) {
        if (_isRefreshing) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          dynamic data = snapshot.data;
          articles ??= [];
          allArticles ??= [];
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
                              .where((article) =>
                                  article['title'] != null &&
                                  article['summary'] != null &&
                                  article['title']
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

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(article['title']?.toString() ?? ''),
                                subtitle:
                                    Text(article['summary']?.toString() ?? ''),
                                onTap: () {
                                  if (article['address'] != null) {
                                    _con.viewPDF(
                                        article['address']?.toString() ?? '',
                                        context);
                                  }
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: likeIcon,
                                      onPressed: () {
                                        setState(() async {
                                          // like relationship
                                          if (await checkArticleLikes(
                                              article['address'])) {
                                            String? email =
                                                _authCon.retrieveEmail();
                                            _con.likeArticle(email!);

                                            //increment like count
                                            _con.updateLikes(article['address'],
                                                article['likeCount'] + 1);

                                            //change icon
                                            likeIcon = Icon(
                                              Icons.favorite,
                                              color: primary,
                                            );
                                          } else {
                                            //dislike relationship
                                            String? email =
                                                _authCon.retrieveEmail();
                                            _con.dislikeArticle(email!);

                                            //decrement like count
                                            _con.updateLikes(article['address'],
                                                article['likeCount'] - 1);

                                            //change icon
                                            likeIcon = Icon(
                                              Icons.favorite_border,
                                              color: primary,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      article['likeCount']?.toString() ?? '0',
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
                                        _con.openCommentScreen(context,
                                            article['id']?.toString() ?? '');
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
