import 'dart:convert';
import 'dart:io';

Future<double> calculateSimilarity(String article1, String article2) async {
  const pythonScriptPath =
      '/Users/leeyilin/Noted-/noted/lib/model/recommendation/topicmodelling.py';
  final process = await Process.start(
    'python3',
    [pythonScriptPath],
  );

  await Future.delayed(const Duration(seconds: 1));

  final sink = process.stdin..writeln('"$article1"\n"$article2"');
  sink.close();

  final similarityOutput = await process.stdout.transform(utf8.decoder).join();
  final similarityScore = double.parse(similarityOutput.trim());

  return similarityScore;
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
