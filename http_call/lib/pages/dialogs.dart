import 'package:flutter/material.dart';

class DialogsPage extends StatefulWidget {
  _DialogsPageState createState() => _DialogsPageState();
}

class _DialogsPageState extends State<DialogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App-bar-------------
      appBar: AppBar(
        title: Text("Dialogs"),
      ),
      //--------------------
      
      // Body----------------
      body: Center(
        // Boton
        child: RaisedButton(
          color: Colors.blue,
          elevation: 10.0,
          onPressed: () {
            showQuitDialog(context).then((vale){});
          },
          child: Text("Tap me"),
          textColor: Colors.white,
        ),
      ),
      //--------------------
    );
  }

  Future<bool> showQuitDialog(BuildContext context) {
    // Builds the alert dialog
    return showDialog(
      context: context,
      barrierDismissible: false, // Doesn't allow the dialog to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Do you want to quit?"),
          actions: <Widget>[
            // Two options
            FlatButton(
              textColor: Colors.blue,
              child: Text('Yes'),
              onPressed: () {
                print("Yes");
              },
            ),
            FlatButton(
              textColor: Colors.blue,
              child: Text('No'),
              onPressed: () {
                print("No");
              },
            ),
          ],
        );
      },
    );
  }
}
