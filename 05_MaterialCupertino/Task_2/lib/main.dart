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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> tabBarNav = [
    {'title': Text('Photo'), 'icon': Icon(Icons.home)},
    {'title': Text('Chat'), 'icon': Icon(Icons.chat)},
    {'title': Text('Alboms'), 'icon': Icon(Icons.album)},
  ];

  TabController _tabController;
  int _currentTabIndex = 0;
  bool _pay = false;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: tabBarNav.length, vsync: this, initialIndex: 0);
    _tabController.addListener(_tabListener);
  }

  _tabListener() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.white,
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                  child: Column(
                children: <Widget>[
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.redAccent,
                      backgroundImage: NetworkImage(
                          'https://docs.oracle.com/en/database/sp_common/shared-images/gs_64_db_cloud_services.png'))
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Home'),
                  ),
                  ListTile(
                    leading: Icon(Icons.portrait),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Images'),
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text('Выход'),
                  ),
                  RaisedButton(
                    child: Text('Регистрация'),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _tabController.index = index;
              _currentTabIndex = index;
            });
          },
          currentIndex: _currentTabIndex,
          items: tabBarNav
              .map((item) => BottomNavigationBarItem(
                    title: item['title'],
                    icon: item['icon'],
                  ))
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.credit_card),
                          title: Text('Сумма'),
                          trailing: Text('200руб')),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            _pay = true;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Оплатить'),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
