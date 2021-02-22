import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
            ),
            ListTile(
              leading: Icon(Icons.portrait),
              title: Text('Artists'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/artists');
              },
            ),
            ListTile(
              leading: Icon(Icons.error_rounded),
              title: Text('Test no page'),
              trailing: Icon(Icons.close),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/test1');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/test1');
          },
          child: Text('Test no page'),
        ),
      ),
    );
  }
}
