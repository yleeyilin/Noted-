import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/controller/articleController.dart';
import '../controller/authController.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> articles = [];
  Future<List<Map<String, dynamic>>>? allArticles;
  List<String> likedArticles = [];
  final ArticleController _con = ArticleController();
  final AuthController _authCon = AuthController();
  bool _isRefreshing = false;
  var likeIcons = <int, Icon>{};

  @override
  void initState() {
    super.initState();
    allArticles = _con.fetchAllArticles();
    fetchLikedArticles();
  }

  Future<void> fetchLikedArticles() async {
    String? userName = _authCon.retrieveName();
    if (userName != null) {
      List<dynamic>? likedArticleAddresses =
          await _con.fetchLikedArticles(userName);
      if (likedArticleAddresses != null) {
        List<String> addresses = likedArticleAddresses.cast<String>();
        setState(() {
          likedArticles = addresses;
        });
      }
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });
    allArticles = _con.fetchAllArticles();
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            return false;
          },
          child: _buildArticleList(),
        ),
      ),
    );
  }

  Widget _buildArticleList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: allArticles,
      builder: (context, snapshot) {
        if (_isRefreshing) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          articles = data;
          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        articles = List<Map<String, dynamic>>.from(data);
                      } else {
                        articles = data
                            .where((article) =>
                                article['title'] != null &&
                                article['summary'] != null &&
                                article['title']
                                    .toString()
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
                          final articleAddress = article['address'];
                          var articleLikeCount = article['likeCount'];
                          final isLiked =
                              likedArticles.contains(articleAddress);
                          if (!likeIcons.containsKey(index)) {
                            likeIcons[index] = isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: primary,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: primary,
                                  );
                          }
                          return SizedBox(
                            width: 200,
                            height: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(article['title']?.toString() ?? ''),
                                subtitle: Text(
                                  article['summary']?.toString() ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  if (articleAddress != null) {
                                    _con.viewPDF(
                                        articleAddress.toString(), context);
                                  }
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: likeIcons[index]!,
                                      onPressed: () async {
                                        // Check if article is already liked
                                        final isArticleLiked = likedArticles
                                            .contains(articleAddress);

                                        // Toggle like relationship
                                        if (isArticleLiked) {
                                          // Dislike relationship
                                          String? email =
                                              _authCon.retrieveEmail();
                                          _con.dislikeArticle(
                                              email!, articleAddress);

                                          // Decrement like count
                                          if (articleLikeCount != null) {
                                            _con.updateLikes(articleAddress,
                                                articleLikeCount - 1);
                                          }

                                          // Update likedArticles list
                                          setState(() {
                                            likedArticles
                                                .remove(articleAddress);
                                          });

                                          // Change icon
                                          setState(() {
                                            likeIcons[index] = Icon(
                                              Icons.favorite_border,
                                              color: primary,
                                            );
                                          });
                                        } else {
                                          // Like relationship
                                          String? email =
                                              _authCon.retrieveEmail();
                                          _con.likeArticle(
                                              email!, articleAddress);

                                          // Increment like count
                                          if (articleLikeCount != null) {
                                            _con.updateLikes(articleAddress,
                                                articleLikeCount + 1);
                                          } else {
                                            _con.updateLikes(articleAddress, 1);
                                          }

                                          // Update likedArticles list
                                          setState(() {
                                            likedArticles.add(articleAddress);
                                          });

                                          // Change icon
                                          setState(() {
                                            likeIcons[index] = Icon(
                                              Icons.favorite,
                                              color: primary,
                                            );
                                          });
                                        }
                                      },
                                    ),
                                    FutureBuilder<Object?>(
                                      future: _con.getLikeCount(articleAddress),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          final likeCount =
                                              snapshot.data as int?;
                                          return Text(
                                            likeCount.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.comment,
                                        color: primary,
                                      ),
                                      onPressed: () {
                                        //to edit
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
