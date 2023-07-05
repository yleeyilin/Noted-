import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/main.dart';

class CommentController {
  Future<void> createCommentNode(String commentContent) async {
    final MutationOptions createCommentOptions = MutationOptions(
      document: gql('''
        mutation CreateComment(\$commentContent: String!) {
          createComment(input: { content: \$commentContent }) {
            comment {
              content
            }
          }
        }
      '''),
      variables: <String, dynamic>{
        'commentContent': commentContent,
      },
    );

    final QueryResult createCommentResult =
        await client.value.mutate(createCommentOptions);

    if (createCommentResult.hasException) {
      print(
          'Create Comment GraphQL Error: ${createCommentResult.exception.toString()}');
      return;
    }

    final dynamic data = createCommentResult.data?['createComment'];
    if (data != null) {
      final dynamic comment = data['comment'];
      final String commentContent = comment['content'] as String;

      print('Created Comment:');
      print('Comment Content: $commentContent');
    }
  }

  Future<List<dynamic>> fetchCommentsForArticle(String articleId) async {
    final QueryOptions fetchCommentsOptions = QueryOptions(
      document: gql('''
        query FetchCommentsForArticle(\$articleId: ID!) {
          article(id: \$articleId) {
            articlescomment {
              content
            }
          }
        }
      '''),
      variables: <String, dynamic>{
        'articleId': articleId,
      },
    );

    final QueryResult fetchCommentsResult =
        await client.value.query(fetchCommentsOptions);

    if (fetchCommentsResult.hasException) {
      print(
          'Fetch Comments GraphQL Error: ${fetchCommentsResult.exception.toString()}');
      return [];
    }

    final dynamic data = fetchCommentsResult.data?['article'];
    if (data != null) {
      final List<dynamic> comments = data['articlescomment'] as List<dynamic>;

      print('Comments for Article:');
      for (final comment in comments) {
        final String commentContent = comment['content'] as String;

        print('Comment Content: $commentContent');
      }

      return comments;
    }

    return [];
  }

  Future<List<dynamic>> fetchComments() async {
    final QueryOptions fetchCommentsOptions = QueryOptions(
      document: gql('''
        query FetchComments {
          comments {
            content
          }
        }
      '''),
    );

    final QueryResult fetchCommentsResult =
        await client.value.query(fetchCommentsOptions);

    if (fetchCommentsResult.hasException) {
      print(
          'Fetch Comments GraphQL Error: ${fetchCommentsResult.exception.toString()}');
      return [];
    }

    final dynamic data = fetchCommentsResult.data;
    if (data != null) {
      final List<dynamic> comments = data['comments'] as List<dynamic>;

      print('Comments:');
      for (final comment in comments) {
        final String commentContent = comment['content'] as String;

        print('Comment Content: $commentContent');
      }

      return comments;
    }

    return [];
  }
}
