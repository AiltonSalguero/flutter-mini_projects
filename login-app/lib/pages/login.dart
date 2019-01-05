import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  String _email;
  String _password;

  // Google Sign In
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
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

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.lightBlueAccent,
                        elevation: 7,
                        child: MaterialButton(
                          onPressed: () => _loginUser(),
                          minWidth: 400,
                          height: 20,
                          elevation: 0,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            "Log In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text("Don\'t have an account?"),
                        FlatButton(
                          onPressed: () {
                            _toSignUpPage();
                          },
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () => _loginUserWithGoogle(),
                      child: Text("Sign In with Google"),
                    )
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
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> _loginUserWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuth =
        await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleSignInAuth.idToken,
      accessToken: googleSignInAuth.accessToken,
    );
    print("Signed as ${user.displayName}");
    print(user);
    Navigator.of(context).pushReplacementNamed('/dashboard');

    return user;
  }

  _loginUser() {
    if (_checkFields()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        print("Signed as ${user.uid}");
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }).catchError((e) {
        print(e);
      });
    }
  }

  _toSignUpPage() {
    Navigator.of(context).pushNamed('/signup');
  }

  Widget _buildMargin() {
    return SizedBox(
      // Margin
      height: 16,
    );
  }
}
