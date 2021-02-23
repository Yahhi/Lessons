import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  String fileData;
  try {
    fileData = await rootBundle.loadString(assetsPath).then((file) => file);
  } catch (ex) {
    fileData = '${assetsPath} файл не найден.';
  }

  return fileData;
}
