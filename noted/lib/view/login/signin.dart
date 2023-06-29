import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/login/forgetpassword.dart';
import 'package:noted/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:noted/controller/authController.dart';

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
  bool _obscurePassword = false;
  final AuthController _con = AuthController();

  onPasswordChanged(String password) {}

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
  }

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
            const SizedBox(height: 5),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: const InputDecoration(
                    labelText: 'NUS Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                  ),
                )
              ),
            const SizedBox(height: 20),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: GestureDetector(
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
                  obscureText: _obscurePassword,
                ),
              ),
            const SizedBox(height: 5),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
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
             ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
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
                        _con.signin(
                            emailController.text, passwordController.text, context);
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
            ),
          ],
        ),
      ),
    ));
  }
}
