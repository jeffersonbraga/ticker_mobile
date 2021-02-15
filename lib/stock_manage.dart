import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ticker_mobile/ticker.dart';

Future<List> fetchAlbum() async {
  final response = await http.get('http://192.168.0.122:8085/ticker/cards');

  if (response.statusCode == 200) {
    final lista = json.decode(response.body) as List;
    final listaTicckers = new List();
    lista.forEach((element) {
      listaTicckers.add(Ticker.fromJson(element));
    });

    return listaTicckers;
  } else {
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  static const Map<int, Color> colorMap = {
    50: Color.fromRGBO(42, 54, 59, 0.1),
    100: Color.fromRGBO(42, 54, 59, 0.2),
    200: Color.fromRGBO(42, 54, 59, 0.3),
    300: Color.fromRGBO(42, 54, 59, 0.4),
    400: Color.fromRGBO(42, 54, 59, 0.5),
    500: Color.fromRGBO(42, 54, 59, 0.6),
    600: Color.fromRGBO(42, 54, 59, 0.7),
    700: Color.fromRGBO(42, 54, 59, 0.8),
    800: Color.fromRGBO(42, 54, 59, 0.9),
    900: Color.fromRGBO(42, 54, 59, 1.0)
  };

  static const MaterialColor _2A363B = MaterialColor(0xFF2A363B, colorMap);

  final String title = "Charts Demo";
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List> futureAlbum;
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return ListView(
                    restorationId: 'list_demo_list_view',
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      for (Ticker t in snapshot.data)
                        ListTile(
                          leading: ExcludeSemantics(),
                          title: Text(
                            t.ticker,
                          ),
                          subtitle: Text(t.valorAtual.toString()),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondRoute()),);
                          }
                        ),
                    ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}