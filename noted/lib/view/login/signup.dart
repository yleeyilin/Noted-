import 'package:flutter/material.dart';
import 'package:noted/model/constant/colors.dart';
import 'package:noted/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:noted/controller/authController.dart';

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
  final AuthController _con = AuthController();

  bool _obscurePassword = false;
  bool _obscurePassword2 = false;

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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  obscureText: _obscurePassword,
                  placeholder: "Enter Password",
                  textAlign: TextAlign.center,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  obscureText: _obscurePassword2,
                  placeholder: "Reenter Password",
                  textAlign: TextAlign.center,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword2 = !_obscurePassword2;
                      });
                    },
                    child: Icon(
                      _obscurePassword2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
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
                      _con.authenticate(
                          emailController.text,
                          resetController.text,
                          passwordController.text,
                          nameController.text,
                          context);
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
