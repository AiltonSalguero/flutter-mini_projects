import 'package:flutter/material.dart';

class GridViewExample extends StatefulWidget {
  GridViewExample({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GridViewExampleState createState() => new _GridViewExampleState();
}

class _GridViewExampleState extends State<GridViewExample> {
  List<String> widgetList = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: widgetList.map((String value) {
            return Container(
              color: Colors.green,
              margin: EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
