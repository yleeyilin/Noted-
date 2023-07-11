import 'package:noted/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> connectNotesToAuthor(String notesAddress, String email) async {
  final MutationOptions connectNotesOptions = MutationOptions(
    document: gql('''
      mutation ConnectNotesToAuthor(\$email: String!, \$notesAddress: String!) {
        updateUsers(
          where: { email: \$email }
          connect: {
            posted: {
              where: { node: { address: \$notesAddress } }
            }
          }
        ) {
          users {
            name
            posted {
              name
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'notesAddress': notesAddress,
    },
  );

  final QueryResult connectNotesResult =
      await client.value.mutate(connectNotesOptions);

  if (connectNotesResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectNotesResult.exception.toString()}');
    return;
  }

  final dynamic data = connectNotesResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? connectedUserEmail = connectedUser['email'] as String?;
      final List? connectedNotes = connectedUser['notes'] as List<dynamic>?;

      print('Connected Author to Notes:');
      print('Author Email: $connectedUserEmail');
      print('Notes:');
      for (final note in connectedNotes ?? []) {
        final String noteName = note['name'] as String;
        final String noteAddress = note['address'] as String;
        print('Name: $noteName, Address: $noteAddress');
      }
    }
  }
}

Future<void> connectAuthorToArticle(String articleAddress, String email) async {
  final MutationOptions connectArticleOptions = MutationOptions(
    document: gql('''
      mutation ConnectAuthorToArticle(\$email: String!, \$articleAddress: String!) {
        updateUsers(
          where: { email: \$email }
          connect: {
            written: {
              where: { node: { address: \$articleAddress } }
            }
          }
        ) {
          users {
            name
            written {
              title
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'articleAddress': articleAddress,
    },
  );

  final QueryResult connectArticleResult =
      await client.value.mutate(connectArticleOptions);

  if (connectArticleResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectArticleResult.exception.toString()}');
    return;
  }

  final dynamic data = connectArticleResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? userName = connectedUser['name'] as String?;
      final List? connectedArticles =
          connectedUser['written'] as List<dynamic>?;

      print('Connected Author to Article:');
      print('Author Name: $userName');
      print('Articles:');
      for (final article in connectedArticles ?? []) {
        final String articleTitle = article['title'] as String;
        final String articleAddress = article['address'] as String;
        print('Title: $articleTitle, Address: $articleAddress');
      }
    }
  }
}

Future<void> connectCourseToNotes(
    String courseName, String notesAddress) async {
  final MutationOptions connectNotesOptions = MutationOptions(
    document: gql('''
      mutation ConnectCourseToNotes(\$courseName: String!, \$notesAddress: String!) {
        updateCourses(
          where: { name: \$courseName }
          connect: {
            notes: {
              where: { node: { address: \$notesAddress } }
            }
          }
        ) {
          courses {
            name
            notes {
              name
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'courseName': courseName,
      'notesAddress': notesAddress,
    },
  );

  final QueryResult connectNotesResult =
      await client.value.mutate(connectNotesOptions);

  if (connectNotesResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectNotesResult.exception.toString()}');
    return;
  }

  final dynamic data = connectNotesResult.data?['updateCourses'];
  if (data != null) {
    final List<dynamic> courses = data['courses'] as List<dynamic>;
    if (courses.isNotEmpty) {
      final dynamic connectedCourse = courses[0];
      final String connectedCourseName = connectedCourse['name'] as String;
      final List<dynamic> connectedNotes =
          connectedCourse['notes'] as List<dynamic>;

      print('Connected Course to Notes:');
      print('Course Name: $connectedCourseName');
      print('Notes:');
      for (final note in connectedNotes) {
        final String noteName = note['name'] as String;
        final String noteAddress = note['address'] as String;
        print('Name: $noteName, Address: $noteAddress');
      }
    }
  }
}

Future<void> connectUserToComment(
    String userName, String commentContent) async {
  final MutationOptions connectUserOptions = MutationOptions(
    document: gql('''
      mutation ConnectUserToComment(\$userName: String!, \$commentContent: String!) {
        updateUser(
          where: { name: \$userName }
          connect: {
            commentedby: {
              where: { node: { content: \$commentContent } }
            }
          }
        ) {
          user {
            name
            commentedby {
              content
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'userName': userName,
      'commentContent': commentContent,
    },
  );

  final QueryResult connectUserResult =
      await client.value.mutate(connectUserOptions);

  if (connectUserResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectUserResult.exception.toString()}');
    return;
  }

  final dynamic data = connectUserResult.data?['updateUser'];
  if (data != null) {
    final dynamic connectedUser = data['user'];
    final String connectedUserName = connectedUser['name'] as String;
    final List<dynamic> connectedComments =
        connectedUser['commentedby'] as List<dynamic>;

    print('Connected User to Comment:');
    print('User Name: $connectedUserName');
    print('CommentedBy:');
    for (final comment in connectedComments) {
      final String commentContent = comment['content'] as String;
      print('Content: $commentContent');
    }
  }
}

Future<void> connectCommentToNotes(
    String commentContent, String notesAddress) async {
  final MutationOptions connectCommentOptions = MutationOptions(
    document: gql('''
      mutation ConnectCommentToNotes(\$commentContent: String!, \$notesAddress: String!) {
        updateComments(
          where: { content: \$commentContent }
          connect: {
            notescomment: {
              where: { node: { address: \$notesAddress } }
            }
          }
        ) {
          comments {
            content
            notescomment {
              name
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'commentContent': commentContent,
      'notesAddress': notesAddress,
    },
  );

  final QueryResult connectCommentResult =
      await client.value.mutate(connectCommentOptions);

  if (connectCommentResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectCommentResult.exception.toString()}');
    return;
  }

  final dynamic data = connectCommentResult.data?['updateComments'];
  if (data != null) {
    final List<dynamic> comments = data['comments'] as List<dynamic>;
    if (comments.isNotEmpty) {
      final dynamic connectedComment = comments[0];
      final String connectedCommentContent =
          connectedComment['content'] as String;
      final List<dynamic> connectedNotes =
          connectedComment['notescomment'] as List<dynamic>;

      print('Connected Comment to Notes:');
      print('Comment Content: $connectedCommentContent');
      print('NotesComment:');
      for (final note in connectedNotes) {
        final String noteName = note['name'] as String;
        final String noteAddress = note['address'] as String;
        print('Name: $noteName, Address: $noteAddress');
      }
    }
  }
}

Future<void> connectCommentToArticle(
    String commentContent, String articleAddress) async {
  final MutationOptions connectCommentOptions = MutationOptions(
    document: gql('''
      mutation ConnectCommentToArticle(\$commentContent: String!, \$articleAddress: String!) {
        updateComments(
          where: { content: \$commentContent }
          connect: {
            articlescomment: {
              where: { node: { address: \$articleAddress } }
            }
          }
        ) {
          comments {
            content
            articlescomment {
              title
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'commentContent': commentContent,
      'articleAddress': articleAddress,
    },
  );

  final QueryResult connectCommentResult =
      await client.value.mutate(connectCommentOptions);

  if (connectCommentResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectCommentResult.exception.toString()}');
    return;
  }

  final dynamic data = connectCommentResult.data?['updateComments'];
  if (data != null) {
    final List<dynamic> comments = data['comments'] as List<dynamic>;
    if (comments.isNotEmpty) {
      final dynamic connectedComment = comments[0];
      final String connectedCommentContent =
          connectedComment['content'] as String;
      final List<dynamic> connectedArticles =
          connectedComment['articlescomment'] as List<dynamic>;

      print('Connected Comment to Articles:');
      print('Comment Content: $connectedCommentContent');
      print('ArticlesComment:');
      for (final article in connectedArticles) {
        final String articleTitle = article['title'] as String;
        final String articleAddress = article['address'] as String;
        print('Title: $articleTitle, Address: $articleAddress');
      }
    }
  }
}

Future<void> connectArticleToArticle(String sourceArticleAddress,
    String targetArticleAddress, double score) async {
  final MutationOptions connectArticleOptions = MutationOptions(
    document: gql('''
      mutation ConnectArticleToArticle(\$sourceArticleAddress: String!, \$targetArticleAddress: String!, \$score: Float!) {
        updateArticles(
          where: { address: \$sourceArticleAddress }
          connect: {
            similarity: {
              where: { node: { address: \$targetArticleAddress } }
              edge: { score: \$score }  
            }
          }
        ) {
          articles {
            title
            similarity {
              title
              score 
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'sourceArticleAddress': sourceArticleAddress,
      'targetArticleAddress': targetArticleAddress,
      'score': score,
    },
  );

  final QueryResult connectArticleResult =
      await client.value.mutate(connectArticleOptions);

  if (connectArticleResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectArticleResult.exception.toString()}');
    return;
  }

  final dynamic data = connectArticleResult.data?['updateArticles'];
  if (data != null) {
    final List<dynamic> articles = data['articles'] as List<dynamic>;
    if (articles.isNotEmpty) {
      final dynamic connectedArticle = articles[0];
      final String connectedArticleTitle = connectedArticle['title'] as String;
      final List? similarArticles =
          connectedArticle['similarity'] as List<dynamic>?;

      print('Connected Articles:');
      print('Source Article Title: $connectedArticleTitle');
      print('Similar Articles:');
      for (final article in similarArticles ?? []) {
        final String similarArticleTitle = article['title'] as String;
        print('Similar Article Title: $similarArticleTitle');
      }
    }
  }
}

//relationship to connect users and liked articles
Future<void> connectUserToArticle(String email) async {
  final MutationOptions connectArticleOptions = MutationOptions(
    document: gql('''
      mutation ConnectUserToArticle(\$email: String!) {
        updateUsers(
          where: { email: \$email }
          connect: {
            liked: {
              where: { node: { address: \$articleAddress } }
            }
          }
        ) {
          users {
            name
            written {
              title
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
    },
  );

  final QueryResult connectArticleResult =
      await client.value.mutate(connectArticleOptions);

  if (connectArticleResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectArticleResult.exception.toString()}');
    return;
  }

  final dynamic data = connectArticleResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? userName = connectedUser['name'] as String?;
      final List? connectedArticles = connectedUser['liked'] as List<dynamic>?;

      print('Connected User to Article:');
      print('User Name: $userName');
      print('Articles:');
      for (final article in connectedArticles ?? []) {
        final String articleTitle = article['title'] as String;
        final String articleAddress = article['address'] as String;
        print('Title: $articleTitle, Address: $articleAddress');
      }
    }
  }
}

//remove relationship between article and user
Future<void> disconnectUserFromArticle(String email) async {
  final MutationOptions disconnectArticleOptions = MutationOptions(
    document: gql('''
      mutation DisconnectUserToArticle(\$email: String!) {
        updateUsers(
          where: { email: \$email }
          disconnect: {
            liked: {
              where: { node: { address: \$articleAddress } }
            }
          }
        ) {
          users {
            name
            written {
              title
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
    },
  );

  final QueryResult disconnectArticleResult =
      await client.value.mutate(disconnectArticleOptions);

  if (disconnectArticleResult.hasException) {
    print(
        'Disconnection GraphQL Error: ${disconnectArticleResult.exception.toString()}');
    return;
  }

  final dynamic data = disconnectArticleResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? userName = connectedUser['name'] as String?;
      final List? connectedArticles = connectedUser['liked'] as List<dynamic>?;

      print('Disconnected User from Article:');
      print('User Name: $userName');
      print('Articles:');
      for (final article in connectedArticles ?? []) {
        final String articleTitle = article['title'] as String;
        final String articleAddress = article['address'] as String;
        print('Title: $articleTitle, Address: $articleAddress');
      }
    }
  }
}
