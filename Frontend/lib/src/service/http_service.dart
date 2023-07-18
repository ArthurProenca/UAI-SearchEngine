import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uai/src/domain/result/search_result_dto.dart';

class HttpService {
  static Future<List<SearchResultDTO>> get(Uri uri) async {
    //return http.get(uri);

    const json = ''' 
    [
   {
      "title":"Functional square root",
      "url":"https://en.wikipedia.org/wiki/Functional_square_root",
      "abs":"Functional <em>square</em> <em>root</em> In mathematics a functional <em>square</em> <em>root</em> sometimes called a half iterate is a <em>square</em> <em>root</em> of a function with respect to the operation of function composition In other words a functional <em>square</em> <em>root</em> of a function is a function satisfying for all "
   }
]''';

    final List<dynamic> parsed = jsonDecode(json);
    return parsed.map((json) => SearchResultDTO.fromJson(json)).toList();
  }
}
