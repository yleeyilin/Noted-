import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> calculateSimilarity(String article1, String article2) async {
  const apiUrl = 'http://localhost:3000/calculate-similarity'; // Replace with your server URL

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'article1': article1, 'article2': article2}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final similarityScore = data['similarityScore'] as double;
    return similarityScore;
  } else {
    throw Exception('Failed to calculate similarity. Status code: ${response.statusCode}');
  }
}

// how to use 
Future<void> main() async {
  String article1 =
      "This is the first article about topic modeling and similarity.";
  String article2 =
      "This is the second article about topic modeling and similarity.";
  Future<double> varf = calculateSimilarity(article1, article2);
  varf.then((result) {
    print(result);
  });
}

