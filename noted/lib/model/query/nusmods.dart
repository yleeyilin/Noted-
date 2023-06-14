import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchNUSMODS() async {
  final response = await http.get(
    Uri.parse('https://api.nusmods.com/v2/2022-2023/moduleList.json'),
    headers: {'accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<String> moduleCodes = [];
    for (var module in data) {
      String moduleCode = module['moduleCode'];
      moduleCodes.add(moduleCode);
    }
    return moduleCodes;
  } else {
    throw Exception('Failed to fetch module codes');
  }
}