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
      final List? connectedNotes =
          connectedUser['notes'] as List<dynamic>?;

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
