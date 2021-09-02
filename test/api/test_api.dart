import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Api Service List Tests', () async {
    final String _apiKey = 'https://restaurant-api.dicoding.dev/';
    String list = 'list';
    final response = await http.get(Uri.parse(_apiKey + list));
    expect(response.statusCode == 200, true);
  });

  test('Api Service Search Tests', () async {
    final String _apiKeySearch =
        'https://restaurant-api.dicoding.dev/search?q=';
    String test = 'kafe';
    final response = await http.get(Uri.parse(_apiKeySearch + test));
    expect(response.statusCode == 200, true);
  });
}
