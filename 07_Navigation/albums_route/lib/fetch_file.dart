import 'package:flutter/services.dart';
// import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;

Future<String> fetchFileFromAssets(String assetsPath) async {
  return rootBundle.loadString(assetsPath).then((file) => file);
}
