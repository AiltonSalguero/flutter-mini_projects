import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpRequestPage extends StatefulWidget {
  _HttpRequestPageState createState() => _HttpRequestPageState();
}

class _HttpRequestPageState extends State<HttpRequestPage> {
  String url =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=846a04086fbe4f6081c32695a0686315";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Request"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _getDataFromUrl,
          textColor: Colors.white,
          elevation: 8.0,
          child: Text("Get News"),
          color: Colors.blue,
        ),
      ),
    );
  }

  //====================== Methods ===============================//
  Future<Null> _getDataFromUrl() async {
    var response =
        await http.get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    print(response.body);
    var decodedData = json.decode(response.body);

    print(decodedData["articles"][0]["source"]["name"]);
  }
}
