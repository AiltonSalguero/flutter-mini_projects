import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  String _email;
  String _password;

  _checkFields() {
    final form = _formkey.currentState;
    
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  _loginUser() {
    if (_checkFields()) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          onPressed: (){},
                          child: Text("Sign Up"),
                        ),
                      ],
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
  Widget _buildMargin() {
    return SizedBox(
      // Margin
      height: 16,
    );
  }
}
