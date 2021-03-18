import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerRepo {
  final String _CAT_FACT_URL = "https://cat-fact.herokuapp.com/facts/random";

  Future<String> fetchStringFromCatFact() async {
    String result;
    try {
      final response = await http.get(_CAT_FACT_URL);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['text'].toString().length > 20) result = data['text'];
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.error);
    }
    return result;
  }
}
