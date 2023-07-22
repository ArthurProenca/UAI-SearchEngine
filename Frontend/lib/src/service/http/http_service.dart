import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uai/src/domain/result/search_result_dto.dart';

class HttpService {
  static Future<SearchResultDTO> get(Uri uri) async {
    return http.get(uri).then((value) {
      var json = value.body;

      final jsonMap = jsonDecode(json.toString());
      return SearchResultDTO.fromJson(jsonMap);
    });
  }
}
