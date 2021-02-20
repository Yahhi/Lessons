import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
  List<Widget> data = List.generate(17, (index) {
    return Card(
      color: Color.fromRGBO(0, 255, 0, index / 50),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('test=$index'),
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double _width = constraints.constrainWidth();
                return _width < 500
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 600),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 7.0,
                          ),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              data[index],
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => data[index],
                      );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
