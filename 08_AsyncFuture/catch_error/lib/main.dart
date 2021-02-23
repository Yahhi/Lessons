import 'package:flutter/material.dart';
import 'fetch_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var filePath = 'assets/artists.json';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaisedButton(
                child: Text('test good file'),
                onPressed: () {
                  setState(() {
                    filePath = 'assets/artists.json';
                  });
                }),
            RaisedButton(
                child: Text('test bad file'),
                onPressed: () {
                  setState(() {
                    filePath = 'assets/artists1.json';
                  });
                }),
            FutureBuilder(
              future: fetchFileFromAssets(filePath),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                    break;
                  case ConnectionState.done:
                    return SingleChildScrollView(
                      child: Text('done! ${snapshot.data}'),
                    );
                    break;
                  case ConnectionState.none:
                    return Text('none');
                    break;
                  default:
                    return Text('default');
                }
              },
            ),
          ],
        ));
  }
}
