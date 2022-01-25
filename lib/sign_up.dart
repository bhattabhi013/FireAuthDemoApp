import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'alert.dart';
import 'fire_auth_provider.dart';
import 'google_auth_provider.dart';
import 'home.dart';
import 'sign_in.dart';

class SignUp extends StatelessWidget {
  static const routeName = 'sign-up';
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  SignUp({Key? key}) : super(key: key);

  final TextEditingController verifyPass = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final googleAuth = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.center,
          child: Card(
            elevation: 2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                        labelText: "E-mail",
                        hintText: "abhishek.bhatt@mail.com"),
                  ),
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  TextField(
                    controller: verifyPass,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Verify Password",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signUp(auth, context);
                    },
                    child: const Text('Sign Up'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      'Already a User?',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.double_arrow_sharp),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignIn.routeName);
                        },
                        textColor: Colors.purple,
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      googleSignUp(googleAuth, context);
                    },
                    child: const Text('Sign up with Google'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void googleSignUp(GoogleSignInProvider auth, BuildContext context) {
    auth.googleLogin().then((value) {
      if (value.status) {
        print('true');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertClass(title: "Auth Failed", message: value.msg);
          },
        );
      }
    });
  }

  void signUp(AuthService auth, BuildContext context) {
    auth
        .signUpEmail(email: emailCtrl.text, password: passCtrl.text)
        .then((value) {
      if (value.status) {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertClass(title: "Auth Failed", message: value.msg);
          },
        );
      }
    });
  }
}
