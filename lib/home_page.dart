import 'package:flutter/material.dart';
import './ticker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:english_words/english_words.dart';

Future<List> fetchPost() async {
  final response = await http.get('http://127.0.0.1:8085/ticker/cards');
  if (response.statusCode == 200) {

    final lista = json.decode(response.body) as List;
    final listaTicckers = new List();

    try {
      lista.forEach((element) {
        listaTicckers.add(Ticker.fromJson(element));
      });
    } catch (e) {
      print(e);
    }
    return listaTicckers;
  } else {
    throw Exception('Falha ao carregar um post');
  }
}

class HomePage extends StatefulWidget {

  const HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final lista = fetchPost();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pegando dados da Web'),
      ),
      body: Center(
        child: FutureBuilder<Ticker>(
          //future: post,
          builder: (context, snapshot) {
            if (lista != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RandomWords()
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}




class TickerListView extends StatefulWidget {

  const TickerListView() : super();

  @override
  _TickerListViewState createState() => _TickerListViewState();

}

class _TickerListViewState extends State<TickerListView> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}






class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  Future<List> futureListTicker;
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    futureListTicker = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );

  }

  Widget _buildSuggestions() {

    FutureBuilder<List>(
      future: futureListTicker,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('snapshot.data.title');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );

    return CircularProgressIndicator();

    /*
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });*/
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}