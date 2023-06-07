import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/login/signin.dart';
import 'package:flutter/cupertino.dart';

//to be continued, link to verify page also

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  void resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Email Sent'),
            content: const Text(
                'Instructions to reset your password have been sent to your email.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            Image.asset(
              'assets/images/logo-white.png',
              height: 100,
            ),
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Enter your NUS email. The instructions will be sent to you shortly.',
              style: TextStyle(
                color: Color.fromARGB(255, 9, 9, 82),
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            /*
            const Text(
              'NUS Email',
              style: TextStyle(
                color: Color.fromARGB(255, 9, 9, 82),
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            */
            SizedBox(
              width: 300,
              child: CupertinoTextField(
                controller: emailController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                  color: inputbox,
                  borderRadius: BorderRadius.circular(9),
                ),
                style: const TextStyle(color: Colors.black),
                placeholder: 'Enter NUS Email',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 9, 9, 82),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 9, 9, 82),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    resetPassword(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                  ),
                  icon: const Icon(Icons.arrow_right_outlined,
                      color: Colors.white),
                  label: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
