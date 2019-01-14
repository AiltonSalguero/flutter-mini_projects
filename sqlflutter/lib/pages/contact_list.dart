import 'package:flutter/material.dart';
import 'package:sqlflutter/database/db_helper.dart';
import 'package:sqlflutter/model/contact.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();

  /// Creates Controller for update name and phone
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
      ),
      body: Container(
        padding:     EdgeInsets.all(16),
        child: FutureBuilder<List<Contact>>(
          future: getContactsFromDB(),
          builder: (context, snapshot) {
            // snapshot.data != null && snapshot.hasData
            //     ? return _buildListView(snapshot)
            //     : return _buildLoading();
            if(snapshot.data != null){
              if (snapshot.hasData){
                return _buildListView(snapshot);
              }
            }
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Future<List<Contact>> getContactsFromDB() async {
    var dbHelper = DBHelper();
    Future<List<Contact>> contacts = dbHelper.getContacts();
    print("=====================================");
    print(contacts);
    return contacts;
  }

  Widget _buildLoading() {
    print("loading");
    return Container(
      alignment: AlignmentDirectional.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView(var snapshot) {
    print("loaded");
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) => Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                        snapshot.data[index].phone,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                  ],
                ),
              ),

              GestureDetector(onTap: () => {},child: Icon(Icons.update, color: Colors.red,),),
              GestureDetector(onTap: () => {},child: Icon(Icons.delete, color: Colors.red,),),
            ],
          ),
    );
  }

  @override
  void initState(){
    super.initState();
  }
}