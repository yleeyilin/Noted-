import 'package:flutter/material.dart';
import 'package:noted/view/widgets/skeleton.dart';
import 'package:noted/controller/authController.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController rNewPasswordController = TextEditingController();
  final AuthController _con = AuthController();

  bool _obscurePassword = false;
  bool _obscurePassword2 = false;
  bool _obscurePassword3 = false;

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
            const SizedBox(height: 155),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextField(
                controller: emailController,
                style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                decoration: const InputDecoration(
                  labelText: 'NUS Email',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                  ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextField(
                controller: oldPasswordController,
                  style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: InputDecoration(
                    labelText: 'Old password',
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
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextField(
                controller: newPasswordController,
                 style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                    border: const OutlineInputBorder(),
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
            const SizedBox(height: 20),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextField(
                controller: rNewPasswordController,
                style: const TextStyle(color: Color.fromARGB(255, 9, 9, 82)),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color:Color.fromARGB(255, 9, 9, 82)), 
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword3 = !_obscurePassword3;
                        });
                      },
                      child: Icon(
                        _obscurePassword3
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: _obscurePassword3,
                ),
              ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Skeleton()),
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
                      _con.change(
                          emailController.text,
                          oldPasswordController.text,
                          newPasswordController.text,
                          rNewPasswordController.text,
                          context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                    ),
                    icon: const Icon(Icons.arrow_right_outlined,
                        color: Colors.white),
                    label: const Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
