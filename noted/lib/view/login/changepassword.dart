import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/widgets/skeleton.dart';
import 'package:flutter/cupertino.dart';
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
                'Old Password',
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
                controller: oldPasswordController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                  color: inputbox,
                  borderRadius: BorderRadius.circular(9),
                ),
                obscureText: _obscurePassword,
                placeholder: "Enter Old Password",
                textAlign: TextAlign.center,
                suffix: GestureDetector(
                  onTap: () {
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
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'New Password',
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
                controller: newPasswordController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                  color: inputbox,
                  borderRadius: BorderRadius.circular(9),
                ),
                obscureText: _obscurePassword2,
                placeholder: "Enter Password",
                textAlign: TextAlign.center,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword2 = !_obscurePassword2;
                    });
                  },
                  child: Icon(
                    _obscurePassword2 ? Icons.visibility : Icons.visibility_off,
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
                controller: rNewPasswordController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                  color: inputbox,
                  borderRadius: BorderRadius.circular(9),
                ),
                obscureText: _obscurePassword3,
                placeholder: "Enter Password",
                textAlign: TextAlign.center,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword3 = !_obscurePassword3;
                    });
                  },
                  child: Icon(
                    _obscurePassword3 ? Icons.visibility : Icons.visibility_off,
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
          ],
        ),
      ),
    );
  }
}
