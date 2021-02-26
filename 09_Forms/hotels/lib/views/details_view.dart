import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/hotel_details.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

const DETAILS_LIST_URL_PREFIX = 'https://run.mocky.io/v3/';

class DetailsView extends StatefulWidget {
  static const routeName = '/details';
  DetailsView({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool isLoading = false;
  bool isError = false;
  HotelDetails data = HotelDetails();

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
      final response = await http.get('$DETAILS_LIST_URL_PREFIX${widget.id}');
      if (response.statusCode == 200) {
        data = HotelDetails.fromJson(json.decode(response.body));
      } else {
        isError = true;
        print(response.statusCode);
      }
    } catch (e) {
      isError = true;
      print(e.error);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: isError
            ? Text('error')
            : data.name == null
                ? Text('loading')
                : Text('${data.name}'),
      ),
      body: Container(
        color: Colors.white,
        child: isError
            ? Center(child: Text('Контент временно недоступен'))
            : data.address == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: CarouselSlider.builder(
                            // key: _sliderKey,
                            unlimitedMode: true,
                            slideBuilder: (index) {
                              return Image.asset(
                                  'assets/images/${data.photos[index]}');
                            },
                            slideTransform: CubeTransform(),
                            slideIndicator: CircularSlideIndicator(
                              padding: EdgeInsets.only(bottom: 32),
                            ),
                            itemCount: data.photos.length),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Row(
                          children: [
                            Text('Страна: '),
                            Text(
                              '${data.address.country}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Row(
                          children: [
                            Text('Город: '),
                            Text('${data.address.city}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Row(
                          children: [
                            Text('Улица: '),
                            Text('${data.address.street}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Row(
                          children: [
                            Text('Рейтинг: '),
                            Text('${data.rating}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 25, bottom: 12),
                        child: Row(
                          children: [
                            Text('Сервисы',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: cWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Платные',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600)),
                                  ...data.services.paid.map((val) => Text(val))
                                ],
                              ),
                            ),
                            Container(
                              width: 20,
                            ),
                            Container(
                              width: cWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Бесплатно',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600)),
                                  ...data.services.free.map((val) => Text(val))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
