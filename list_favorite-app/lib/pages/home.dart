import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:list_fav/pages/saved_names.dart';

class RandomWords extends StatefulWidget {
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  //final List<WordPair> _suggestions = <WordPair>[]; // Is redundant
  final _suggestions = <WordPair>[];
  final _wordPair = WordPair.random();

  ///Saves the favorite names
  final _savedNames = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(generatedName) {
    //Creates one row which has the startup names
    final bool _alreadySaved = _savedNames.contains(generatedName);

    return ListTile(
      title: Text(
        generatedName.asPascalCase, //generated names
        style: _biggerFont,
      ),
      trailing: _showFavIcon(_alreadySaved),
      onTap: () => _addOrRemoveFavorite(_alreadySaved, generatedName),
    );
  }

  Widget _buildSuggestions() {
    //Creates a infinite list with all the names.
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, i) {
        if (i.isOdd) return Divider();

        //Integer result, calculates the number of names.
        final int index = i ~/ 2;
        if (index >= _suggestions.length) {
          //When you already reached the end of the avaiable names
          //generates and adds 10 more.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _showFavIcon(alreadySaved) {
    //Blank or red
    return Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          //return SavedNamesPage(_savedNames, _biggerFont);
          //return Scaffold(appBar: AppBar(title: Text("hola",),),body: Text("data"),);
          final tiles = _savedNames.map(
            (favoriteNames) {
              return ListTile(
                title: Text(
                  favoriteNames.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          // return Scaffold(
          //   appBar: new AppBar(
          //     title: Text("Saved names:"),
          //   ),
          //   body: ListView(
          //     children: divided,
          //   ),
          // );
          return SavedNamesPage(_savedNames, _biggerFont);
        },
      ),
    );
  }

  void _addOrRemoveFavorite(alreadySaved, generatedName) {
    //Interactivity for the fav icon
    setState(() {
      if (alreadySaved) {
        _savedNames.remove(generatedName);
      } else {
        _savedNames.add(generatedName);
      }
    });
  }
}
