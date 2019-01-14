import 'package:flutter/material.dart';
import 'package:sqlflutter/database/db_helper.dart';
import 'package:sqlflutter/model/contact.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqlflutter/pages/contact_list.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name;
  String _phone;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("SQL with Flutter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list),
            tooltip: 'View List',
            onPressed: () => _toContactList(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                validator: (val) => val.length == 0 ? "Enter your name" : null,
                onSaved: (val) => this._name = val,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Phone",
                ),
                validator: (val) => val.length == 0 ? "Enter your phone" : null,
                onSaved: (val) => this._phone = val,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  onPressed: _submitContact,
                  child: Text("Add a new contact"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Shows Contact List View
  void _toContactList() {
    Navigator.of(context).pushNamed('/list');
  }

  void _submitContact() {
    this.formKey.currentState.validate()
        ? this.formKey.currentState.save()
        : null;

    Contact contact = new Contact();
    contact.name = _name;
    contact.phone = _phone;
    print(contact.name);

    var dbHelper = DBHelper();
    dbHelper.addNewContact(contact);
    // Fluttertoast.showToast(
    //   msg: "Contact saved",
    //   toastLength: Toast.LENGTH_SHORT,
    //   backgroundColor: Colors.white,
    //   textColor: Colors.black,
    // );
  }
}
