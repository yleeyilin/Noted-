import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/login/signin.dart';
import 'package:noted/view/widgets/skeleton.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  late User? user;
  late Timer? timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user?.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: AlertDialog(
        title: const Center(
          child: Text(
            'Verify Email',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        content: Text(
          'An email has been sent to ${user?.email}. Please verify.',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user?.reload();
    if (user!.emailVerified) {
      timer?.cancel();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Skeleton(),
        ),
      );
    }
  }
}
