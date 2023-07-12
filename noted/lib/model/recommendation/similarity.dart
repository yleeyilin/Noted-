import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> calculateSimilarity(String article1, String article2) async {
  const apiUrl = 'http://localhost:5000/calculate-similarity';
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'article1': article1, 'article2': article2}),
  );

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    final similarityScore = responseJson['similarityScore'];

    if (similarityScore is num) {
      return similarityScore.toDouble();
    } else {
      throw Exception('Invalid similarity score format');
    }
  } else {
    throw Exception(
        'Failed to calculate similarity. Status code: ${response.statusCode}');
  }
}