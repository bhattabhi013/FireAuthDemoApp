import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alert.dart';
import 'fire_auth_provider.dart';
import 'home.dart';
import 'sign_up.dart';

class SignIn extends StatelessWidget {
  static const routeName = '/sign-in';
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.center,
          child: Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                        labelText: "E-mail",
                        hintText: "abhishek.bhatt@gmail.com"),
                  ),
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // print('${emailCtrl.text.trim()} pass ${passCtrl.text.trim()}');
                      signIn(auth, context);
                    },
                    child: const Text('Sign In'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      'New User?',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_add),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUp.routeName);
                        },
                        textColor: Colors.purple,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(AuthService auth, BuildContext context) {
    auth
        .signInWithEmail(email: emailCtrl.text, password: passCtrl.text)
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
