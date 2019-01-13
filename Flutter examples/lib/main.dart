import 'package:flutter/material.dart';

import 'package:examples/examples/custom_appbar_scaffold.dart'; // First
import 'package:examples/examples/tutorial_home.dart';  // Second
import 'package:examples/examples/my_button.dart'; // Third
import 'package:examples/examples/counter.dart';
import 'package:examples/examples/counter_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterTwo(),
    );
  }
}
