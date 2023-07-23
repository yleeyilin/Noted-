import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noted/view/login/splashscreen.dart';
import 'model/authentication/firebase_options.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:noted/neo4jupdate/sync.dart';

//final HttpLink httpLink = HttpLink('http://localhost:4000/graphql');
final HttpLink httpLink = HttpLink('https://us-central1-noted-393604.cloudfunctions.net/runApolloServer');


final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);

void main() async {
  // createCourseNodesFromNUSMODS();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        //title: 'Noted!',
        home: SplashScreen(),
      ),
    );
  }
}
