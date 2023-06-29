import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/main.dart';


Future<String?> getUserId(String email) async {
  const String findUserIdQuery = '''
    query FindUserId(\$email: String!) {
      user(email: \$email) {
        _id
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(findUserIdQuery),
    variables: {'email': email},
  );

  final QueryResult result = await client.value.query(options);
  if (result.hasException) {
    print('Error loading user: ${result.exception.toString()}');
    return null;
  }
  final userId = result.data?['user']['id'] as String?;
  return userId;
}

Future<int?> getReputationScore(String email) async {
  const String findUserQuery = '''
    query FindUser(\$email: String!) {
      user(email: \$email) {
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
  
  final reputation = result.data?['user']['reputation'] as int?;
  return reputation;
}