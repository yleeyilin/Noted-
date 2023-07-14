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

Future<List?> fetchNotes(String courseCode) async {
  final QueryOptions options = QueryOptions(
    document: gql('''
        query GetNotes(\$courseCode: String!) {
          courses(where: { name: \$courseCode }) {
            notes {
              name
              address
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

Future<List<dynamic>> fetchArticles() async {
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
