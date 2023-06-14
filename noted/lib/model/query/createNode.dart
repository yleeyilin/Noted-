import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/main.dart';

Future<void> createCourseNode(String name) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
      mutation CreateCourse(\$name: String!) {
        createCourses(input: { name: \$name }) {
          courses {
            name
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'name': name,
    },
  );

  final QueryResult result = await client.value.mutate(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final Map<String, dynamic>? data = result.data?['createCourses'];
    if (data != null) {
      final List<dynamic> courseData = data['courses'] as List<dynamic>;
      if (courseData.isNotEmpty) {
        final Map<String, dynamic> firstCourse = courseData.first as Map<String, dynamic>;
        final String courseName = firstCourse['name'] as String;
        print('Create Course Success: $courseName');
      } else {
        print('No courses returned in the response.');
      }
    }
  }
}



Future<void> createNotesNode(String name, File pdfFile) async {
  final rawContent = await pdfFile.readAsBytes();
  final pdfContent = String.fromCharCodes(rawContent);

  final MutationOptions options = MutationOptions(
    document: gql('''
      mutation CreateNotes(\$name: String!, \$content: String!) {
        createNotes(input: { name: \$name, content: \$content }) {
          success
          message
        }
      }
    '''),
    variables: <String, dynamic>{
      'name': name,
      'content': pdfContent,
    },
  );

  final QueryResult result = await client.value.mutate(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final Map<String, dynamic>? data = result.data?['createNotes'];
    if (data != null) {
      final bool success = data['success'] as bool;
      final String message = data['message'] as String;
      print('Create Notes Success: $success');
      print('Message: $message');
    }
  }
}

Future<void> createArticleNode(String title, String summary, File pdfFile) async {
  final rawContent = await pdfFile.readAsBytes();
  final pdfContent = String.fromCharCodes(rawContent);

  final MutationOptions options = MutationOptions(
    document: gql('''
      mutation CreateArticle(\$title: String!, \$summary: String!, \$content: String!) {
        createArticle(input: { title: \$title, summary: \$summary, content: \$content }) {
          success
          message
        }
      }
    '''),
    variables: <String, dynamic>{
      'title': title,
      'summary': summary,
      'content': pdfContent,
    },
  );

  final QueryResult result = await client.value.mutate(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final Map<String, dynamic> data = result.data?['uploadPDF'];
    final bool success = data['success'] as bool;
    final String message = data['message'] as String;
    print('Upload Success: $success');
    print('Message: $message');
  }
}

void createUserNode(String name, String email) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
        mutation CreateUser(\$name: String!, \$email: String!) {
          createUsers(input: {name: \$name, email: \$email}) {
            users {
              name 
              email
            }
          }
        }
      '''),
    variables: <String, dynamic>{
      'name': name,
      'email': email,
    },
  );

  final QueryResult result = await client.value.mutate(options);
  if (result.hasException) {
    print('Error creating user: ${result.exception.toString()}');
  } else {
    print('User created successfully');
    print('Created user data: ${result.data}');
  }
}

Future<void> createInterestNode(String name) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
      mutation CreateInterest(\$name: String!) {
        createInterest(input: { name: \$name }) {
          success
          message
        }
      }
    '''),
    variables: <String, dynamic>{
      'name': name,
    },
  );

  final QueryResult result = await client.value.mutate(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final Map<String, dynamic>? data = result.data?['createInterest'];
    if (data != null) {
      final bool success = data['success'] as bool;
      final String message = data['message'] as String;
      print('Create Interest Success: $success');
      print('Message: $message');
    }
  }
}
