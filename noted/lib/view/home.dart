import 'package:flutter/material.dart';
import 'package:noted/controller/profileController.dart';
import 'package:noted/view/comment/articleComment.dart';
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
  final ProfileController _pCon = ProfileController();
  bool _isRefreshing = false;
  var likeIcons = <int, Icon>{};

  @override
  void initState() {
    super.initState();
    allArticles = _con.fetchAllArticles();
    fetchLikedArticles();
  }

//error
  Future<void> fetchLikedArticles() async {
    String? userName = await _pCon.retrieveUserName();
    print(userName);
    if (userName != null) {
      List<dynamic>? likedArticleAddresses =
          await _con.fetchLikedArticles(userName);
      if (likedArticleAddresses != null) {
        List<String> addresses = likedArticleAddresses.cast<String>();
        setState(() {
          likedArticles = addresses;
          print(likedArticles);
        });
      } else {
        print("liked articles is null");
      }
    } else {
      print("username is null");
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
                                    _con.viewPDF(articleAddress, context);
                                  }
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: likeIcons[index]!,
                                      onPressed: () async {
                                        final isArticleLiked = likedArticles
                                            .contains(articleAddress);

                                        if (isArticleLiked) {
                                          String? email =
                                              _authCon.retrieveEmail();
                                          _con.dislikeArticle(
                                              email!, articleAddress);

                                          if (articleLikeCount != null) {
                                            _con.updateLikes(articleAddress,
                                                articleLikeCount - 1);
                                          }

                                          setState(() {
                                            likedArticles
                                                .remove(articleAddress);
                                            article['likeCount'] =
                                                article['likeCount'] - 1;
                                          });

                                          setState(() {
                                            likeIcons[index] = Icon(
                                              Icons.favorite_border,
                                              color: primary,
                                            );
                                          });
                                        } else {
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

                                          setState(() {
                                            likedArticles.add(articleAddress);
                                            article['likeCount'] =
                                                article['likeCount'] + 1;
                                          });

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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ArticleComment(
                                              address: articleAddress,
                                            ),
                                          ),
                                        );
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
