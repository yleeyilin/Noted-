import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/model/constant/colors.dart';
import 'package:noted/widgets/skeleton.dart';
import 'package:noted/view/login/forgetpassword.dart';
import 'package:noted/view/login/login.dart';
import 'package:noted/model/authentication/showsnackbar.dart';
import 'package:flutter/cupertino.dart';

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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
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
            const SizedBox(height: 200),
            const Center(
              child: Text(
                'NUS Email',
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 9, 82),
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 5),
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
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Password',
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 9, 82),
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: CupertinoTextField(
                controller: passwordController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                  color: inputbox,
                  borderRadius: BorderRadius.circular(9),
                ),
                obscureText: true,
                suffix: GestureDetector(
                  onTap: () {
                    // Toggle the password visibility
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 9, 9, 82),
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
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Skeleton(),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      showErrorSnackbar(context, error);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                  ),
                  icon: const Icon(Icons.arrow_right_outlined,
                      color: Colors.white),
                  label: const Text(
                    'Submit',
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
    ));
  }
}
