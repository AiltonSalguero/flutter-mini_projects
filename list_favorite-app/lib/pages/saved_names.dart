import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SavedNamesPage extends StatelessWidget {
  //final Iterable<Widget> _savedNames;
  final Set<WordPair> _savedNames;
  final _biggerFont;

  SavedNamesPage(this._savedNames, this._biggerFont);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = _savedNames.map(
      (WordPair favoriteNames) {
        return ListTile(
          title: Text(
            favoriteNames.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    
    return Scaffold(
      appBar: new AppBar(
        title: Text("Saved names:"),
      ),
      body: ListView(
        children: divided,
        //children: <Widget>[Text("data")],
      ),
    );
  }
}
