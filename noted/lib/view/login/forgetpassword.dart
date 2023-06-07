import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/login/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:noted/controller/authController.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  final AuthController _con = AuthController();

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
                    _con.reset(emailController.text, context);
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
