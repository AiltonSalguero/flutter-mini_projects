import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatefulWidget {
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  String _email;
  String _password;

  // GOOGLE
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign Up",
        ),
      ),

      //------BODY---------//
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              // Contains all the widgets
              padding: EdgeInsets.all(25),
              child: Form(
                // Allows to validate the data
                key: _formkey,
                child: Column(
                  // For having all widgets in a line
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Logo
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70.0,
                      backgroundImage: AssetImage("assets/logo.png"),
                    ),

                    _buildMargin(),
                    // Input for the email
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "Email is blank" : null,
                      onSaved: (value) => _email = value,
                      decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    _buildMargin(),
                    // Input for the password
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "Password is blank" : null,
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    _buildMargin(),

                    // Register Button
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.lightBlueAccent,
                        elevation: 7,
                        child: MaterialButton(
                          onPressed: () => _createUser(),
                          minWidth: 400,
                          height: 20,
                          elevation: 0,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //------------------//
    );
  }

  _checkFields() {
    // Validates the data
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> _createUserWithGoogle() async {
    GoogleSignInAccount googleSignInAcc = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuth =
        await googleSignInAcc.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleSignInAuth.idToken,
      accessToken: googleSignInAuth.accessToken,
    );
    print("Signed as ${user.displayName}");
    print(user);
    Navigator.of(context).pushReplacementNamed('/home');

    return user;
  }


  _createUser() {
    // Creates a user in firebase 
    if (_checkFields()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((user) {
        print("Signed in ${user.uid}");

        // When you signUp you won't be able to go back to the login page
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }).catchError((e) {
        print(e);
      });
    }
  }

  Widget _buildMargin() {
    return SizedBox(
      // Margin
      height: 16,
    );
  }
}
