import 'package:http/http.dart' as http;
import 'dart:convert';

class RetrieveCourse {
  final String apiUrl = 'https://api.nusmods.com/v2/2022-2023/moduleList.json';

  Future<List<String>> getModuleCodes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final moduleList = json.decode(response.body);

        //extract mods
        final moduleCodes = [
          for (var module in moduleList) module['moduleCode']
        ];

        return moduleCodes.cast<String>();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error occurred: $error');
    }

    return [];
  }
}
