import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/model/constant/colors.dart';
import 'package:noted/view/login/login.dart';
import 'package:noted/model/authentication/showsnackbar.dart';
import 'package:noted/view/login/verify.dart';
import 'package:noted/widgets/skeleton.dart';
import 'package:noted/model/query/createNode.dart';
import 'package:flutter/cupertino.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
              const SizedBox(height: 155),
              const Center(
                child: Text(
                  'Name',
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
                  controller: nameController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  style: const TextStyle(color: Colors.black),
                  placeholder: 'Enter Name',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
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
                  style: const TextStyle(color: Colors.black),
                  placeholder: 'Enter NUS Email',
                  textAlign: TextAlign.center,
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  style: const TextStyle(color: Colors.black),
                  placeholder: 'Enter Password',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Confirm Password',
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
                  controller: resetController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  style: const TextStyle(color: Colors.black),
                  placeholder: 'Reenter Password',
                  textAlign: TextAlign.center,
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
                      if (emailController.text.endsWith("@u.nus.edu") &&
                          (resetController.text == passwordController.text)) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          value.user!.sendEmailVerification().then((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Verify(),
                              ),
                            );
                          });
                          createUserNode(
                              nameController.text, emailController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Skeleton(),
                            ),
                          );
                        }).catchError((error) {
                          // Failed to create user
                          print(error.toString());
                          showErrorSnackbar(context, "Invalid email domain");
                        });
                      } else {
                        // Invalid email domain
                        showErrorSnackbar(context, "Password does not match");
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                    ),
                    icon: const Icon(Icons.arrow_right_outlined,
                        color: Colors.white),
                    label: const Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
