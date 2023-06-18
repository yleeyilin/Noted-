import 'package:noted/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> connectCourseToNotes(String courseName, String notesURL) async {
  // Step 1: Find the notes node based on the notesURL
  final QueryOptions notesQueryOptions = QueryOptions(
    document: gql('''
      query FindNotes(\$notesURL: String!) {
        notes(address: \$notesURL) {
          id
        }
      }
    '''),
    variables: <String, dynamic>{
      'notesURL': notesURL,
    },
  );

  final QueryResult notesQueryResult = await client.value.query(notesQueryOptions);

  if (notesQueryResult.hasException) {
    print('GraphQL Error: ${notesQueryResult.exception.toString()}');
    return;
  }

  final String notesId = notesQueryResult.data?['notes'][0]['id'] as String;

  // Step 2: Find the course based on the courseName
  final QueryOptions courseQueryOptions = QueryOptions(
    document: gql('''
      query FindCourse(\$courseName: String!) {
        course(name: \$courseName) {
          id
        }
      }
    '''),
    variables: <String, dynamic>{
      'courseName': courseName,
    },
  );

  final QueryResult courseQueryResult = await client.value.query(courseQueryOptions);

  if (courseQueryResult.hasException) {
    print('GraphQL Error: ${courseQueryResult.exception.toString()}');
    return;
  }

  final String courseId = courseQueryResult.data?['course']['id'] as String;

  // Step 3: Connect the course node and notes node using their respective IDs
  final MutationOptions connectNotesOptions = MutationOptions(
    document: gql('''
      mutation ConnectCourseToNotes(\$courseId: ID!, \$notesId: ID!) {
        updateCourse(
          where: { id: \$courseId }
          connect: { notes: { where: { id: \$notesId } } }
        ) {
          course {
            name
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'courseId': courseId,
      'notesId': notesId,
    },
  );

  final QueryResult connectNotesResult = await client.value.mutate(connectNotesOptions);

  if (connectNotesResult.hasException) {
    print('GraphQL Error: ${connectNotesResult.exception.toString()}');
    return;
  }

  final dynamic data = connectNotesResult.data?['updateCourse'];
  if (data != null) {
    final dynamic courseData = data['course'];
    final String connectedCourseName = courseData['name'] as String;

    print('Connected Course to Notes:');
    print('Course Name: $connectedCourseName');
  }
}