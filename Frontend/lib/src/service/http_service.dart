import 'package:http/http.dart' as http;

class HttpService {
  static Future<Object> get(Uri uri) async {
    return http.get(uri);
  }
}
