import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/hotel.dart';

const HOTELS_LIST_URL =
    'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301';

class HomeView extends StatefulWidget {
  static const routeName = '/';
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  bool isListShow = true;
  List<HotelPreview> hotels = List<HotelPreview>();
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    getDataDio();
  }

  getDataDio() async {
    setState(() {
      isLoading = true;
    });

    try {
      final resp = await dio.get(HOTELS_LIST_URL);
      hotels = resp.data
          .map<HotelPreview>((hotel) => HotelPreview.fromJson(hotel))
          .toList();
    } on DioError catch (e) {
      print(e.error);
      print(e.response.statusCode);
      print(e.response.statusMessage);
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget getListCard(HotelPreview record) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            image: DecorationImage(
              image: AssetImage('assets/images/${record.poster}'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(record.name),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/details', arguments: {'id': record.uuid});
                  },
                  child: Text(
                    'Подробнее',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getGridCard(HotelPreview record) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10.0,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/${record.poster}'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  record.name,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0))),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/details',
                              arguments: {'id': record.uuid});
                        },
                        child: Text(
                          'Подробнее',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        //title: Text('Hotel list'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.list_rounded),
              onPressed: () {
                setState(() {
                  isListShow = true;
                });
              },
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.grid_on),
              onPressed: () {
                setState(() {
                  isListShow = false;
                });
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isListShow ? 1 : 2,
                childAspectRatio: isListShow ? 1.5 : 1.0,
                // mainAxisSpacing: 1.0,
                // crossAxisSpacing: 4.0,
              ),
              itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                return isListShow
                    ? getListCard(hotels[index])
                    : getGridCard(hotels[index]);
              }),
    );
  }
}
