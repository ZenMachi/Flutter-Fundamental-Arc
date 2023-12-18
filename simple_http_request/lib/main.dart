import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_http_request/album.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<Album> _futureAlbum;

  @override
  void initState() {
    // TODO: implement initState
    _futureAlbum = fetchAlbum();
    super.initState();
  }

  Future<Album> fetchAlbum() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Album');
    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Album'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: _futureAlbum,
                builder: (context, snapshot) {
                 var state = snapshot.connectionState;
                 if (state != ConnectionState.done) {
                   return CircularProgressIndicator();
                 } else {
                   if (snapshot.hasData) {
                     return Text(snapshot.data!.title);
                   } else if (snapshot.hasError) {
                     return Text("${snapshot.error}");
                   } else {
                     return Text('');
                   }
                 }
                })
          ],
        ),
      ),
    );
  }
}


