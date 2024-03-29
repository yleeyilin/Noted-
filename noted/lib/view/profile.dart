import 'package:flutter/material.dart';
import 'package:noted/view/login/changepassword.dart';
import 'package:noted/view/login/login.dart';
import 'package:noted/controller/profileController.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final _controller = TextEditingController();
  bool isEditingName = false;
  //String name = "";
  final ProfileController _con = ProfileController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                child: FutureBuilder<String?>(
                  future: _con.retrieveUserName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading name');
                    } else {
                      final name = snapshot.data ?? '';
                      return Text(
                        name.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isEditingName = true;
                      });
                    },
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
                child: FutureBuilder<int?>(
                  future: _con.retrieveReputation(),
                  builder:
                      (BuildContext context, AsyncSnapshot<int?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading reputation');
                    } else {
                      final reputation = snapshot.data ?? 0;
                      return Text(
                        reputation.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
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
                      setState(() {
                        isEditingName = false;
                      });
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
                      setState(() {
                        isEditingName = false;
                      });
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
