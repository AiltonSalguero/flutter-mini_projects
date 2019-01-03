import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ///
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //App bar
        appBar: AppBar(
          title: Text('List'),
        ),
        //---------------

        //Body
        body: listOfList()

        //---------------
        );
  }

  Widget listOfList() {
    ///Lista que estara dentro de la otra lista
    final list = List.generate(10, (i) => "Item ${i + 1}");
    
    return ListView.builder(
      itemBuilder: (context, i) => ExpansionTile(
          title: Text("Header ${i + 1}"),
          children: list
              .map((val) => ListTile(
                    title: Text(val),
                  ))
              .toList()),
      itemCount: 5,
    );
  }

  Widget expansion() {
    return ExpansionPanelList(
      expansionCallback: (i, bool val) {
        setState(
          () {
            _isExpanded = !val;
          },
        );
      },
      children: [
        ExpansionPanel(
          body: Container(
            padding: EdgeInsets.all(15.0),
            child: Text('First Panel'),
          ),
          headerBuilder: (BuildContext context, bool val) {
            return Center(
              child: Text('First panel'),
            );
          },
          isExpanded: _isExpanded,
        ),
      ],
    );
  }

  Widget simpleList() {
    //Lista con 3 elementos
    return ListView(
      children: <Widget>[
        Text('First Element'),
        Text('Second Element'),
        Text('Third Element'),
      ],
    );
  }

  Widget infiniteList() {
    //Lista con infinitos elementos
    return ListView.builder(
      padding: EdgeInsets.all(5.0),
      itemBuilder: (context, index) => ListTile(
            title: Text('List element'),
            subtitle: Text('This is a list item'),
          ),
    );
  }

  Widget finiteList(length) {
    //Lista con un numero determinado de elementos
    return ListView.builder(
      itemCount: length,
      padding: EdgeInsets.all(5.0),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('List element'),
          subtitle: Text('This is a list item'),
          trailing: Icon(Icons.access_alarm),
        );
      },
    );
  }
}
