import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/model/constant/colors.dart';
import 'package:noted/widgets/skeleton.dart';
import 'package:noted/model/authentication/showsnackbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() {
    return _ChangePasswordState();
  }
}

//to edit

class _ChangePasswordState extends State<ChangePassword> {
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
            const SizedBox(height: 155),
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
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Confirm Password',
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Skeleton()),
                    );
                  },
                  style:
                      OutlinedButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    if (emailController.text.endsWith("@u.nus.edu")) {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Skeleton(),
                          ),
                        );
                      }).catchError((error) {
                        // Failed to create user
                        showErrorSnackbar(context, error);
                      });
                    } else {
                      // Invalid email domain
                      showErrorSnackbar(context, "Invalid email domain");
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_outlined),
                  label: const Text('Change'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
