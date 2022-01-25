import 'package:fire_app/cache_Demo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'alert.dart';
import 'fire_auth_provider.dart';
import 'google_auth_provider.dart';
import 'sign_up.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final googleAuth = Provider.of<GoogleSignInProvider>(context);

    print('user $user');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Firebase Application',
          softWrap: true,
          style: TextStyle(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // const Center(
          //   child: const Text("Hello There! Logged In"),
          // ),
          const SizedBox(height: 10),
          // Center(
          //     child: FlatButton(
          //   onPressed: () async {
          //     // selectFile();
          //     final result =
          //         await FilePicker.platform.pickFiles(allowMultiple: false);
          //     if (result == null) return;
          //     final path = result.files.single.path!;
          //     print('path ${path}');
          //   },
          //   textColor: Colors.purple,
          //   child: const Text('Upload file'),
          // )
          FlatButton(
            onPressed: () {
              signOut(auth, context, googleAuth);
              // Navigator.of(context).pushReplacementNamed(SignUp.routeName);
            },
            textColor: Colors.purple,
            child: const Text('Sign out'),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 150,
              width: 150,
              imageUrl:
                  "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamed(CacheDemo.routeName);
          //   },
          //   child: Text("Demo Screen"),
          // ),
          // ),
        ],
      ),
    );
  }

  void signOut(
      AuthService auth, BuildContext context, GoogleSignInProvider gAuth) {
    if (user!.providerData[0].providerId == "google.com") {
      // signed via google
      gAuth.handleSignOut();
    }
    auth.logOut().then((value) {
      if (value.status) {
        Navigator.of(context).pushReplacementNamed(SignUp.routeName);
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

// selectFile() async {
//   final result = await FilePicker.platform.pickFiles(allowMultiple: false);

//   if (result == null) return;
//   final path = result.files.single.path!;
//   print('path ${path}');
// }
