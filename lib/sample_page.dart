import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ticker_mobile/home_page.dart';
import 'package:ticker_mobile/ticker.dart';

Future<List> fetchAlbum() async {
  final response = await http.get('http://192.168.2.105:8085/ticker/cards');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return Ticker.fromJson(jsonDecode(response.body));
    final lista = json.decode(response.body) as List;
    final listaTicckers = new List();
    lista.forEach((element) {
      listaTicckers.add(Ticker.fromJson(element));
    });

    return listaTicckers;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List> futureAlbum;
  final _suggestions = <Ticker>[];
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
                          leading: ExcludeSemantics(
                            /*child:
                            //CircleAvatar(child: Text('')),
                            Image.network(
                              t.logo,
                              width: 300,
                              height: 150,
                            )*/
                          ),
                          title: Text(
                            t.ticker,
                          ),
                          subtitle: Text(t.valorAtual.toString()),
                          //onTap: _showDetailFromTicker(t),


                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondRoute()),);
                          },
                          onLongPress: _showDetailFromTicker(t),
                          tileColor: Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                    ],



                  /*
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: /*1*/ (context, i) {

                    if (i.isOdd) return Divider(); /*2*/

                    final index = i ~/ 2; /*3*/
                    if(index < snapshot.data.length) {
                      Ticker itemTicker = snapshot.data.elementAt(index);
                      /*if (index >= snapshot.data.length) {
                        _suggestions.add(itemTicker); /*4*/
                      }*/
                      return _buildRow(itemTicker.ticker);
                    } else {
                      return Text("");
                    }
                }*/);


                return Text((snapshot.data.last as Ticker).ticker);
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

  Widget _buildRow(String ticker) {
    return ListTile(
      title: Text(
        ticker,
        style: _biggerFont,
      ),
    );
  }

  _showDetailFromTicker(Ticker t) {
    print("_showDetailFromTicker");
    //SecondRoute();
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