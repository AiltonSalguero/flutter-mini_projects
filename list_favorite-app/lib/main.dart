import 'package:flutter/material.dart';

import 'package:list_fav/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartUp Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RandomWords(),
    );
  }
}

