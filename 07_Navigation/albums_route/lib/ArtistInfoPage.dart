import 'package:flutter/material.dart';

class ArtistInfoPage extends StatefulWidget {
  static const routeName = '/artistinfo';
  ArtistInfoPage({Key key, this.title, this.about}) : super(key: key);
  final String title;
  final String about;

  @override
  _ArtistInfoPageState createState() => _ArtistInfoPageState();
}

class _ArtistInfoPageState extends State<ArtistInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
            flex: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.about,
                  style: TextStyle(fontSize: 18),
                ))),
      ),
    );
  }
}
