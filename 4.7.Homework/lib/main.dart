import 'package:flutter/material.dart';

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
  final List<String> nav = ['Список 1', 'Список 2'];

  final List fakeData =
      List.generate(100, (int index) => 'https://picsum.photos/1200/${index}');

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: nav.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Homework example'),
          bottom: TabBar(
              tabs: nav
                  .map((String item) => Tab(
                        text: item,
                      ))
                  .toList()),
        ),
        body: TabBarView(
          children: nav.map((name) {
            return ListView(
                key: PageStorageKey(name),
                children: fakeData.map((item) {
                  return Text(item);
                }).toList());
          }).toList(),
        ),
      ),
    );
  }
}
