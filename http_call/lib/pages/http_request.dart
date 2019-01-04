import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http_call/model/sentence.dart';

class HttpRequestPage extends StatefulWidget {
  _HttpRequestPageState createState() => _HttpRequestPageState();
}

class _HttpRequestPageState extends State<HttpRequestPage> {
  final _newsUrl =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=846a04086fbe4f6081c32695a0686315";
  final _app_id = "c078a9d0";
  final _app_key = "fa8b3145a7f435b135000eb889afba4a";

  SentencesExample _sentencesExample;
  final _wordController = TextEditingController();

  String _allData = "data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Request"),
      ),
      body: Column(
        children: <Widget>[
          // Input for the search
          TextField(
            controller: _wordController,

            /// Variable for the input
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a word',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),

          // Search Button
          RaisedButton(
            onPressed: () =>
                _getDataFromUrl(_dictionarySentences(_wordController.text)),
            textColor: Colors.white,
            elevation: 8.0,
            child: Text("Get Sentence"),
            color: Colors.blue,
          ),
          Text(
            "Example:",
            style: TextStyle(fontSize: 20),
          ),

          Expanded(
            child: _sentencesExample == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  padding: EdgeInsets.all(2.0),
                  childAspectRatio: 6,
                  children: _sentencesExample.sentence
                      .map(
                        (sen) => Text(sen.text.toString(), style: TextStyle(fontSize: 16.0,),)
                      )
                      .toList(),
                ),
          )

        ],
      ),
    );
  }

  //====================== Methods ===============================//
  Future<Null> _getDataFromUrl(url) async {
    var response = await http.get(Uri.encodeFull(url), headers: {
      'Accept': 'application/json',
      'app_id': _app_id,
      'app_key': _app_key
    });

    /// Converts JSON to an array
    var decodedData = json.decode(response.body);
    print("=====================================");
    print("=====================================");
    //print(decodedData);
    print(decodedData['results']);
    print(
        decodedData['results'][0]['lexicalEntries'][0]['sentences'][0]['text']);
    print(decodedData['results'][0]['lexicalEntries'][0]['sentences']);
    _sentencesExample = SentencesExample.fromJson(
        decodedData['results'][0]['lexicalEntries'][0]);

    setState(() {
      // _sentence = decodedData['results'][0]['lexicalEntries'][0]['sentences'][0]
      //     ['text'];
      // _sentence1 = response.body;
    });
  }

  String _dictionarySearch(word) {
    final String language = "en";
    final wordId = word
        .toLowerCase(); //word id is case sensitive and lowercase is required
    return "https://od-api.oxforddictionaries.com:443/api/v1/search/" +
        language +
        "?q=" +
        wordId;
  }

  String _dictionarySentences(word) {
    final String language = "en";
    final wordId = word
        .toLowerCase(); //word id is case sensitive and lowercase is required
    return "https://od-api.oxforddictionaries.com:443/api/v1/entries/" +
        language +
        "/" +
        wordId +
        "/sentences";
  }
}
