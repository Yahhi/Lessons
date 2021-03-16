import 'package:flutter/material.dart';

import 'space.dart';

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
  Widget getListCard(Space record) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailView(
              data: record,
            ),
          ));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10.0,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: AssetImage(record.image),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                    color: Colors.grey,
                  ),
                  padding:
                      EdgeInsets.only(top: 10, left: 10, bottom: 20, right: 40),
                  child: Text(
                    record.description,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 10,
                child: Icon(
                  Icons.add_box_sharp,
                  size: 30,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3,
          ),
          itemCount: spaces.length,
          itemBuilder: (BuildContext context, int index) {
            return getListCard(spaces[index]);
          }),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({Key key, this.data}) : super(key: key);
  final Space data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Hero(tag: data.id, child: Image.asset(data.image)),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Hero(
                    tag: '${data.id}-button',
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 90,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Hero(
                tag: '${data.id}-title',
                child: Material(child: Text(data.description))),
          ],
        ),
      ),
    );
  }
}
