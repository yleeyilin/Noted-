import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/main.dart';
import 'package:noted/model/colors.dart';
import 'package:noted/view/login/login.dart';
import 'package:noted/model/authentication/showsnackbar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noted/view/login/verify.dart';
import 'package:noted/widgets/skeleton.dart';

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
  TextEditingController nameController = TextEditingController();

  void createUserNode(String name, String email) async {
    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation CreateUser(\$name: String!, \$email: String!) {
          createUsers(input: {name: \$name, email: \$email}) {
            users {
              name 
              email
            }
          }
        }
      '''),
      variables: <String, dynamic>{
        'name': name,
        'email': email,
      },
    );

    final QueryResult result = await client.value.mutate(options);
    if (result.hasException) {
      print('Error creating user: ${result.exception.toString()}');
    } else {
      print('User created successfully');
      print('Created user data: ${result.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          decoration: BoxDecoration(
            color: primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              Image.asset(
                'assets/images/logo-darkblue.png',
                height: 100,
              ),
              const SizedBox(height: 155),
              const Center(
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    filled: true,
                    fillColor: inputbox,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'NUS Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    filled: true,
                    fillColor: inputbox,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    filled: true,
                    fillColor: inputbox,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Confirm Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    filled: true,
                    fillColor: inputbox,
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
                    style:
                        OutlinedButton.styleFrom(foregroundColor: Colors.white),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      if (emailController.text.endsWith("@u.nus.edu")) {
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
                          showErrorSnackbar(context, error);
                        });
                      } else {
                        // Invalid email domain
                        showErrorSnackbar(context, "Invalid email domain");
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.arrow_right_outlined),
                    label: const Text('Create'),
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
