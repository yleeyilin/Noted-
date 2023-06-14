import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/query/nusmods.dart';

class CourseController extends ControllerMVC {
  factory CourseController() => _this ??= CourseController._();
  CourseController._();
  static CourseController? _this;

  Future<List<String>> fetchModuleCodes() async {
    return fetchNUSMODS();
  }
}
