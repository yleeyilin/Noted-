import 'package:flutter/material.dart';
import 'package:noted/view/login/login.dart';
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

  bool _obscurePassword = true;
  bool _obscurePassword2 = true;

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
              const SizedBox(height: 120),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                  ),
                )
              ),
              const SizedBox(height: 25),
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
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: resetController,
                  style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                    suffixIcon: GestureDetector(
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
                  obscureText: _obscurePassword2,
                ),
              ),
              const SizedBox(height: 50),
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
                        _con.authenticate(
                          emailController.text,
                          resetController.text,
                          passwordController.text,
                          nameController.text,
                          context,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                      ),
                      icon: const Icon(Icons.arrow_right_outlined, color: Colors.white),
                      label: const Text(
                        'Create',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
