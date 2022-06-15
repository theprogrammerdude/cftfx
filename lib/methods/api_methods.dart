import 'package:http/http.dart' as http;

class ApiMethods {
  Future<http.Response> getHistoric(String pair) async {
    String today = DateTime.now().toString().split(' ')[0];
    String yesterday = DateTime.now()
        .subtract(const Duration(days: 1))
        .toString()
        .split(' ')[0];

    // print(
    //     'https://api.polygon.io/v2/aggs/ticker/X:$pair/range/1/minute/$yesterday/$today?adjusted=true&sort=asc&limit=5000&apiKey=3r5A4iEkMqoBUNWCRPq2xBSJf0I82WfO');

    var url = Uri.parse(
        'https://api.polygon.io/v2/aggs/ticker/X:$pair/range/1/minute/$yesterday/$today?adjusted=true&sort=asc&limit=50000&apiKey=3r5A4iEkMqoBUNWCRPq2xBSJf0I82WfO');

    var res = await http.get(url);
    return res;
  }
}
