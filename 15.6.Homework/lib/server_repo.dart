import 'dart:convert';
import 'package:http/http.dart' as http;
import 'general_repo.dart';

class ServerRepo extends GeneralRepo {
  final String _CAT_FACT_URL = "https://cat-fact.herokuapp.com/facts/random";

  @override
  Future<String> fetchCatFact() async {
    String result;
    try {
      final response = await http.get(_CAT_FACT_URL);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['text'].toString().length > 20) {
          result = data['text'];
          GeneralRepo.data.add(result);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.error);
    }
    return result;
  }
}
