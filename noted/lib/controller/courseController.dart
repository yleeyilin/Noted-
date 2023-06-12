import 'dart:convert';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class CourseController extends ControllerMVC {
  factory CourseController() => _this ??= CourseController._();
  CourseController._();
  static CourseController? _this;

  Future<List<String>> fetchModuleCodes() async {
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
}