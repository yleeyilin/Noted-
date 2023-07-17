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

Future<void> connectArticleToArticle(String sourceArticleAddress,
    String targetArticleAddress, double score) async {
  final MutationOptions connectArticleOptions = MutationOptions(
    document: gql('''
      mutation ConnectArticleToArticle(\$sourceArticleAddress: String!, \$targetArticleAddress: String!, \$score: Float!) {
        updateArticles(
          where: { address: \$sourceArticleAddress }
          connect: {
            related: {
              where: { node: { address: \$targetArticleAddress } }
              edge: { score: \$score }  
            }
          }
        ) {
          articles {
            title
            related {
              title
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
Future<void> connectUserToArticle(String email, String articleAddress) async {
  final MutationOptions connectArticleOptions = MutationOptions(
    document: gql('''
      mutation ConnectUserToArticle(\$email: String!, \$address: String!) {
        updateUsers(
          where: { email: \$email }
          connect: {
            likes: {
              where: { node: { address: \$address } }
            }
          }
        ) {
          users {
            name
            likes {
              title
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'address': articleAddress,
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
Future<void> disconnectUserFromArticle(
    String email, String articleAddress) async {
  final MutationOptions disconnectArticleOptions = MutationOptions(
    document: gql('''
      mutation DisconnectUserFromArticle(\$email: String!, \$address: String!) {
        updateUsers(
          where: { email: \$email }
          disconnect: {
            likes: {
              where: { node: { address: \$address } }
            }
          }
        ) {
          users {
            name
            likes {
              title
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'address': articleAddress,
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

//remove relationship between note and user
Future<void> disconnectUserFromNote(String email, String noteAddress) async {
  final MutationOptions disconnectNotesOptions = MutationOptions(
    document: gql('''
      mutation DisconnectUserFromNote(\$email: String!, \$address: String!) {
        updateUsers(
          where: { email: \$email }
          disconnect: {
            likedNotes: {
              where: { node: { address: \$address } }
            }
          }
        ) {
          users {
            name
            likedNotes {
              name
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'address': noteAddress,
    },
  );

  final QueryResult disconnectNoteResult =
      await client.value.mutate(disconnectNotesOptions);

  if (disconnectNoteResult.hasException) {
    print(
        'Disconnection GraphQL Error: ${disconnectNoteResult.exception.toString()}');
    return;
  }

  final dynamic data = disconnectNoteResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? userName = connectedUser['name'] as String?;
      final List? connectedNotes = connectedUser['likedby'] as List<dynamic>?;

      print('Disconnected User from Note:');
      print('User Name: $userName');
      print('Notes:');
      for (final note in connectedNotes ?? []) {
        final String noteName = note['name'] as String;
        final String noteAddress = note['address'] as String;
        print('Name: $noteName, Address: $noteAddress');
      }
    }
  }
}

//relationship to connect users and liked notes
Future<void> connectUserToNote(String email, String noteAddress) async {
  final MutationOptions connectNoteOptions = MutationOptions(
    document: gql('''
      mutation ConnectUserToNote(\$email: String!, \$address: String!) {
        updateUsers(
          where: { email: \$email }
          connect: {
            likedNotes: {
              where: { node: { address: \$address } }
            }
          }
        ) {
          users {
            name
            likedNotes {
              name
              address
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'address': noteAddress,
    },
  );

  final QueryResult connectNoteResult =
      await client.value.mutate(connectNoteOptions);

  if (connectNoteResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectNoteResult.exception.toString()}');
    return;
  }

  final dynamic data = connectNoteResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? userName = connectedUser['name'] as String?;
      final List? connectedNotes = connectedUser['likedby'] as List<dynamic>?;

      print('Connected User to Article:');
      print('User Name: $userName');
      print('Notes:');
      for (final note in connectedNotes ?? []) {
        final String noteName = note['name'] as String;
        final String noteAddress = note['address'] as String;
        print('Name: $noteName, Address: $noteAddress');
      }
    }
  }
}

//connect comment node to the user node
Future<void> connectCommentToAuthor(String content, String email) async {
  final MutationOptions connectCommentOptions = MutationOptions(
    document: gql('''
      mutation ConnectCommentToAuthor(\$content: String!, \$email: String!) {
        updateUsers(
          where: { email: \$email }
          connect: {
            commentedby: {
              where: { node: { content: \$content } }
            }
          }
        ) {
          users {
            name
            commentedby {
              content
            }
          }
        }
      }
    '''),
    variables: <String, dynamic>{
      'email': email,
      'content': content,
    },
  );

  final QueryResult connectCommentResult =
      await client.value.mutate(connectCommentOptions);

  if (connectCommentResult.hasException) {
    print(
        'Connection GraphQL Error: ${connectCommentResult.exception.toString()}');
    return;
  }

  final dynamic data = connectCommentResult.data?['updateUsers'];
  if (data != null) {
    final List<dynamic> users = data['users'] as List<dynamic>;
    if (users.isNotEmpty) {
      final dynamic connectedUser = users[0];
      final String? connectedUserEmail = connectedUser['email'] as String?;
      final List? connectedComment = connectedUser['comment'] as List<dynamic>?;

      print('Connected Author to Comment:');
      print('Author Email: $connectedUserEmail');
      print('Comments:');
      for (final comment in connectedComment ?? []) {
        final String noteContent = comment['content'] as String;
        print('Name: $noteContent');
      }
    }
  }
}

// //connect comment node to the notes node
// Future<void> connectCommentToNote(String content, String address) async {
//   final MutationOptions connectCommentOptions = MutationOptions(
//     document: gql('''
//       mutation ConnectCommentToNote(\$content: String!, \$address: String!) {
//         updateNotes(
//           where: { address: \$address }
//           connect: {
//             notesComment: {
//               where: { node: { content: \$content } }
//             }
//           }
//         ) {
//           notes{
//             name
//             notesComment{
//               content
//             }
//           }
//         }
//       }
//     '''),
//     variables: <String, dynamic>{
//       'content': content,
//       'address': address,
//     },
//   );

//   final QueryResult connectCommentResult =
//       await client.value.mutate(connectCommentOptions);

//   if (connectCommentResult.hasException) {
//     print(
//         'Connection GraphQL Error: ${connectCommentResult.exception.toString()}');
//     return;
//   }

//   final dynamic data = connectCommentResult.data?['updateNotes'];
//   if (data != null) {
//     final List<dynamic> notes = data['notes'] as List<dynamic>;
//     if (notes.isNotEmpty) {
//       final dynamic connectedNote = notes[0];
//       final String? connectedAddress = connectedNote['address'] as String?;
//       final List? connectedComment =
//           connectedNote['notesComment'] as List<dynamic>?;

//       print('Connected Note to Comment:');
//       print('Author Email: $connectedAddress');
//       print('Notes:');
//       for (final comment in connectedComment ?? []) {
//         final String noteContent = comment['content'] as String;
//         print('Name: $noteContent');
//       }
//     }
//   }
// }
