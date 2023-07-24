import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class RequestHelper {
  static Future<dynamic> getRequest(String url) async {
    var response = await (http.get(Uri.parse(url)));
    print('Request with status: ${response.statusCode}.');
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        return decodeData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  // get request with headers
  static Future<dynamic> postRequestWithHeaders(
      String url, Map<String, String>? headers, var body) async {
    var response =
        await (http.post(Uri.parse(url), headers: headers, body: body));
    print('Toll Request with status: ${response.statusCode}.');
    print('Toll Request with body: ${response.body}.');

    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodeData = jsonDecode(data);

        return decodeData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }
}
