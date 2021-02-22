import 'package:flutter/material.dart';
import 'fetch_file.dart';
import 'dart:convert';

class ArtistsPage extends StatefulWidget {
  static const routeName = '/artists';
  ArtistsPage({Key key}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  List<dynamic> data;

  Future loadJsonData() async {
    var jsonText = await fetchFileFromAssets('assets/artists.json');
    setState(() => data = json.decode(jsonText));
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Artists'),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: Icon(Icons.portrait),
                title: Text(
                  'Artists',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              )
            ],
          ),
        ),
        body: data == null
            ? Text('...loading...')
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('${data[index]["name"]}'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/artistinfo', arguments: {
                      'title': data[index]["name"].toString(),
                      'about': data[index]['about'].toString()
                    });
                  },
                ),
              ));
  }
}
