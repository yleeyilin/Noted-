import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/main.dart';

Future<int?> getReputationScore(String email) async {
  const String findUserQuery = '''
    query FindUser(\$email: String!) {
      users(where: { email: \$email }) {
        reputation
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(findUserQuery),
    variables: {'email': email},
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('Error loading user: ${result.exception.toString()}');
    return null;
  }

  final List<dynamic> users = result.data?['users'];
  if (users.isNotEmpty) {
    final reputation = users[0]['reputation'] as int?;
    print(reputation);
    return reputation;
  }

  return null;
}

Future<String?> getUserName(String currEmail) async {
  const String findUserNameQuery = '''
    query FindUserName(\$currEmail: String!) {
      users(where: { email: \$currEmail }) {
        name
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(findUserNameQuery),
    variables: {'currEmail': currEmail},
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('Error loading user: ${result.exception.toString()}');
    return null;
  }

  final List<dynamic> users = result.data?['users'];
  if (users.isNotEmpty) {
    final name = users[0]['name'] as String?;
    print(name);
    return name;
  }
  return null;
}

Future<int?> likeCount(String articleAddress) async {
  const String findLikeCountQuery = '''
    query FindLikeCount(\$articleAddress: String!) {
      articles(where: { address: \$articleAddress }) {
        likeCount
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(findLikeCountQuery),
    variables: {'articleAddress': articleAddress},
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('Error loading like count: ${result.exception.toString()}');
    return null;
  }

  final List<dynamic> articles = result.data?['articles'];
  if (articles.isNotEmpty) {
    final likeCount = articles[0]['likeCount'] as int?;
    print(likeCount);
    return likeCount;
  }
  return null;
}

Future<List?> fetchNotes(String courseCode) async {
  final QueryOptions options = QueryOptions(
    document: gql('''
        query GetNotes(\$courseCode: String!) {
          courses(where: { name: \$courseCode }) {
            notes {
              name
              address
              likeCount
            }
          }
        }
      '''),
    variables: <String, dynamic>{
      'courseCode': courseCode,
    },
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final dynamic data = result.data?['courses'];
    if (data != null) {
      final List<dynamic> notesData = data[0]['notes'] as List<dynamic>;
      return notesData;
    }
  }
  return null;
}

Future<List<Map<String, dynamic>>> fetchArticles() async {
  final QueryOptions options = QueryOptions(
    document: gql('''
      query GetArticles {
        articles {
          title
          summary
          address
          likeCount
        }
      }
    '''),
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
    return []; // Return an empty list on error
  } else {
    final dynamic data = result.data?['articles'];
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
  }
  return [];
}

//check for liked relationship
Future<bool> checkArticleLikes(String articleAddress, String name) async {
  final QueryOptions checkLikesOptions = QueryOptions(
    document: gql('''
      query CheckArticleLikes(\$articleAddress: String!, \$name: String!) {
        articles(where: { address: \$articleAddress }) {
          likes(where: { name: \$name }) {
            name
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'articleAddress': articleAddress,
      'name': name,
    },
  );

  final QueryResult checkLikesResult =
      await client.value.query(checkLikesOptions);

  if (checkLikesResult.hasException) {
    print('GraphQL Error: ${checkLikesResult.exception.toString()}');
    return false;
  }

  final dynamic data = checkLikesResult.data?['articles'];
  if (data != null) {
    final List<dynamic> likes = data[0]['likes'] as List<dynamic>;

    return likes.isNotEmpty;
  }

  return false;
}

Future<List<dynamic>> likedArticles(String name) async {
  final QueryOptions options = QueryOptions(
    document: gql('''
    query LikedArticles(\$name: String!) {
      users(where: {name: \$name}) {
        likes {
          title
          summary
          address
        }
      }
    }
  '''),
    variables: {'name': name},
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
    return []; // Return an empty list on error
  } else {
    final dynamic data = result.data?['user']?['likedArticles'];
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
  }

  return [];
}

//gets liked notes
Future<List<dynamic>> likedNotes(String name) async {
  final QueryOptions options = QueryOptions(
    document: gql('''
    query LikedNotes(\$name: String!) {
      users(where: {name: \$name}) {
        likedNotes {
          name
          address
        }
      }
    }
  '''),
    variables: {'name': name},
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
    return []; // Return an empty list on error
  } else {
    final dynamic data = result.data?['user']?['likedNotes'];
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
  }

  return [];
}

//get like count of notes
Future<int?> likeCountNotes(String noteAddress) async {
  const String findLikeCountQuery = '''
    query FindLikeCount(\$noteAddress: String!) {
      notes(where: { address: \$noteAddress }) {
        likeCount
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(findLikeCountQuery),
    variables: {'noteAddress': noteAddress},
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('Error loading like count: ${result.exception.toString()}');
    return null;
  }

  final List<dynamic> notes = result.data?['notes'];
  if (notes.isNotEmpty) {
    final likeCount = notes[0]['likeCount'] as int?;
    print(likeCount);
    return likeCount;
  }
  return null;
}

//fetch comments -- notes
Future<List<dynamic>?> fetchComments(String noteAddress) async {
  final QueryOptions options = QueryOptions(
    document: gql('''
      query GetComments(\$noteAddress: String!) {
        comments(where: { noteAddress: \$noteAddress}) {
          content
        }
      }
    '''),
    variables: <String, dynamic>{
      'noteAddress': noteAddress,
    },
  );

  final QueryResult result = await client.value.query(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final List<dynamic>? data = result.data?['comments'];
    if (data != null) {
      return data;
    }
  }
  return null;
}
