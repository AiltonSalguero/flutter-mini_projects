import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You are now logged in",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              OutlineButton(
                onPressed: () {
                  _logOutUser();
                },
                child: Text("LogOut"),
                borderSide: BorderSide(
                  color: Colors.red,
                  style: BorderStyle.solid,
                  width: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logOutUser() {
    // Logs out the user
    FirebaseAuth.instance.signOut().then((action) {
      // Shows again the log in page
      Navigator.of(context).pushReplacementNamed('/landingpage');
    }).catchError((e) {
      print(e);
    });
  }
}
