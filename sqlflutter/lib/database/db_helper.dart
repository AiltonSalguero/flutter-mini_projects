import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlflutter/model/contact.dart';

class DBHelper {
  final String tableName = "Contact";
  static Database db_instance;

  Future<Database> get db async {
    if (db_instance == null) db_instance = await initDB();
    return db_instance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ContactsDB.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);

    return db;
  }

  /// Creates Table
  void onCreateFunc(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT);");
  }

  /// CRUD
  /// Get contacts
  Future<List<Contact>> getContacts() async {
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery("SELECT * FROM $tableName");
    List<Contact> contacts = new List();

    for (int i = 0; i < list.length; i++) {
      int id = list[i]['id'];
      String name = list[i]['name'];
      String phone = list[i]['phone'];

      Contact contact = new Contact(id, name, phone);
      contacts.add(contact);
    }
    return contacts;
  }

  /// Adds a contact
  void addNewContact(Contact contact) async {
    var db_connection = await db;
    String query =
        "INSERT INTO $tableName(name, phone) VALUES(\'${contact.name}\'. \'${contact.phone}\')";
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /// Updates a contact
  void updateContact(Contact contact) async {
    var db_connection = await db;
    String query =
        "UPDATE $tableName SET name=\'${contact.name}\', phone=\'${contact.phone}\' WHERE id=${contact.id}";
    await db_connection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  /// Deletes a contact
  void deleteContact(Contact contact) async {
    var db_connection = await db;
    String query = "DELETE FROM $tableName WHERE id=${contact.id}";
    await db_connection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }
}
