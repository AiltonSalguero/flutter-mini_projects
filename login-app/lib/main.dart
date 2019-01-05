import 'package:flutter/material.dart';

import 'package:login/pages/login.dart';
import 'package:login/pages/sign_up.dart';
import 'package:login/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      // Creates the routes for the different pages
      routes: <String, WidgetBuilder>{
        '/landingpage' : (BuildContext context) => LoginPage(),
        '/signup' : (BuildContext context) => SignUpPage(),
        '/dashboard' : (BuildContext context) => HomePage(),
      },
    );
  }
}
