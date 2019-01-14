import 'package:flutter/material.dart';

import 'package:sqlflutter/pages/home.dart';
import 'package:sqlflutter/pages/contact_list.dart';
import 'package:sqlflutter/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/list' : (BuildContext context) => ContactListPage(),
        '/home' : (BuildContext context) => HomePage(),
      },
    );
  }
}
