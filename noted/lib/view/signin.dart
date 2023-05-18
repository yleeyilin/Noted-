import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/view/home.dart';
import 'package:noted/view/login.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            Image.asset(
              'assets/images/logo-darkblue.png',
              height: 100,
            ),
            const SizedBox(height: 200),
            const Center(
              child: Text(
                'NUS Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  filled: true,
                  fillColor: inputbox,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  filled: true,
                  fillColor: inputbox,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  style:
                      OutlinedButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  },
                  style:
                      OutlinedButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.arrow_right_outlined),
                  label: const Text('Submit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
