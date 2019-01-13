import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int count;
  CounterDisplay({this.count});

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  final VoidCallback onPressed;
  CounterIncrementor({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

class CounterTwo extends StatefulWidget {
  @override
  _CounterTwoState createState() => _CounterTwoState();
}

class _CounterTwoState extends State<CounterTwo> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      CounterIncrementor(
        onPressed: _increment,
      ),
      CounterDisplay(
        count: _counter,
      ),
    ]);
  }
}
