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
        final Map<String, dynamic> firstCourse =
            courseData.first as Map<String, dynamic>;
        final String courseName = firstCourse['name'] as String;
        print('Create Course Success: $courseName');
      } else {
        print('No courses returned in the response.');
      }
    }
  }
}

Future<void> createNotesNode(String name, String address) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
      mutation CreateNotes(\$name: String!, \$address: String!) {
        createNotes(input: { name: \$name, address: \$address, likes: 0 }) {
          notes {
            name
            address
            likes
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'name': name,
      'address': address,
    },
  );

  final QueryResult result = await client.value.mutate(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final Map<String, dynamic>? data = result.data?['createNotes'];
    if (data != null) {
      final List<dynamic> noteData = data['notes'] as List<dynamic>;
      if (noteData.isNotEmpty) {
        final Map<String, dynamic> firstNote =
            noteData.first as Map<String, dynamic>;
        final String notesName = firstNote['name'] as String;
        final String notesAddress = firstNote['address'] as String;
        final int notesLikes = firstNote['likes'] as int;

        print(
            'Create Notes Success - Name: $notesName, Address: $notesAddress, Likes: $notesLikes');
      } else {
        print('No notes returned in the response.');
      }
    }
  }
}

Future<void> createArticleNode(
    String title, String summary, String address) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
      mutation CreateArticle(\$title: String!, \$summary: String!, \$address: String!) {
        createArticles(input: { title: \$title, summary: \$summary, address: \$address, likes: 0}) {
          articles {
            title
            summary
            address
            likes
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'title': title,
      'summary': summary,
      'address': address,
    },
  );

  final QueryResult result = await client.value.mutate(options);

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
  } else {
    final Map<String, dynamic>? data = result.data?['createArticles'];
    if (data != null) {
      final List<dynamic> articles = data['articles'] as List<dynamic>;
      for (final article in articles) {
        final String articleTitle = article['title'] as String;
        final String articleSummary = article['summary'] as String;
        final String articleAddress = article['address'] as String;
        final int articleLikes = article['likes'] as int;

        print('Create Article Success:');
        print('Title: $articleTitle');
        print('Summary: $articleSummary');
        print('Address: $articleAddress');
        print('Likes: $articleLikes');
      }
    }
  }
}

Future<void> createUserNode(String name, String email) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
        mutation CreateUser(\$name: String!, \$email: String!, \$reputation: Int!) {
          createUsers(input: { name: \$name, email: \$email, reputation: \$reputation }) {
            users {
              name
              email
              reputation
            }
          }
        }
      '''),
    variables: <String, dynamic>{
      'name': name,
      'email': email,
      'reputation': 0,
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
