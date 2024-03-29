import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/main.dart';

//updates the like count for articles
Future<void> updateLikeCount(String address, int likeCount) async {
  const mutation = r'''
  mutation UpdateLikeCount($address: String!, $likeCount: Int!) {
    updateArticles(
      where: {
        address: $address
      }
      update: {
        likeCount: $likeCount
      }
    ) {
      articles {
        likeCount
      }
    }
  }
''';
  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: <String, dynamic>{
      'address': address,
      'likeCount': likeCount,
    },
  );

  try {
    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    }
  } catch (e) {
    print('Error updating like count: $e');
  }
}

//updates the like count for notes
Future<void> updateLikeCountNotes(String address, int likeCount) async {
  const mutation = r'''
  mutation UpdateLikeCountNotes($address: String!, $likeCount: Int!) {
    updateNotes(
      where: {
        address: $address
      }
      update: {
        likeCount: $likeCount
      }
    ) {
      notes {
        likeCount
      }
    }
  }
''';
  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: <String, dynamic>{
      'address': address,
      'likeCount': likeCount,
    },
  );

  try {
    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    }
  } catch (e) {
    print('Error updating like count: $e');
  }
}
