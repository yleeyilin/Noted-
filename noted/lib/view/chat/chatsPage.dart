import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noted/view/chat/chat.dart';

// class Functions {
//   static void updateAvailability() {
//     final firestore = FirebaseFirestore.instance;
//     final auth = FirebaseAuth.instance;
//     final data = {
//       'name': auth.currentUser!.displayName ?? auth.currentUser!.email,
//       'date_time': DateTime.now(),
//       'email': auth.currentUser!.email,
//     };
//     try {
//       firestore.collection('Users').doc(auth.currentUser!.uid).set(data)
//     } catch (e) {
//       print(e);
//     }
//   }
// }

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  List<User> users = null; //to add
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => Chat(
                        currentUserEmail: '',
                        otherUserEmail: user.email,
                      )));
                }
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white)),
                  ),
                  child: Text(user.name),
                ),
              )
            }));
  }
}
