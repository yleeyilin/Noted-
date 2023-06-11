import 'package:mvc_pattern/mvc_pattern.dart';

class PostController extends ControllerMVC {
  factory PostController() => _this ??= PostController._();
  PostController._();
  static PostController? _this;
}
