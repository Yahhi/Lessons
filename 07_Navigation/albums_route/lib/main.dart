import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'ArtistsPage.dart';
import 'ArtistInfoPage.dart';
import 'NotFound.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomePage.routeName:
            return MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            });
            break;
          case ArtistsPage.routeName:
            return PageRouteBuilder(
              pageBuilder: (c, a1, a2) => ArtistsPage(),
              transitionsBuilder: (c, anim, a2, child) {
                CurvedAnimation _curved = CurvedAnimation(
                    parent: anim, curve: Curves.fastLinearToSlowEaseIn);
                Animation<double> _animate =
                    Tween<double>(begin: 0.0, end: 1.0).animate(_curved);
                return ScaleTransition(
                  scale: _animate,
                  child: FadeTransition(
                    opacity: anim,
                    child: child,
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 2000),
            );
            break;
          case ArtistInfoPage.routeName:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (BuildContext context) {
              if (args != null &&
                  args.containsKey('title') &&
                  args.containsKey('about')) {
                return ArtistInfoPage(
                  title: args['title'],
                  about: args['about'],
                );
              }
              return ArtistInfoPage();
            });
            break;
          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return NotFound();
            });
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return NotFound();
        });
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
