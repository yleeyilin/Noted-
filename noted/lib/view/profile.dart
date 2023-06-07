import 'package:flutter/material.dart';
import 'package:noted/view/constant/colors.dart';
import 'package:noted/view/login/changepassword.dart';
import 'package:noted/view/login/login.dart';
import 'package:noted/view/widgets/skeleton.dart';
import 'package:flutter/cupertino.dart';

//get data for name and reputation score

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final _controller = TextEditingController();
  //connect to database
  String name = " ";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  controller: _controller,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              //'edit icon' button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 300),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 9, 9, 82),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Reputation Score',
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
                  decoration: BoxDecoration(
                    color: inputbox,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePassword(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "CHANGE PASSWORD",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Skeleton(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 9, 9, 82),
                      ),
                    ),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Color.fromARGB(255, 9, 9, 82),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      name = _controller.text;
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 9, 82),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 9, 9, 82),
                      ),
                    ),
                    child: const Text(
                      "SIGN OUT",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Color.fromARGB(255, 9, 9, 82),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
