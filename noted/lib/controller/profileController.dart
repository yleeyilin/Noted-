import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/neo4j/retrieve.dart';
import 'package:noted/model/authentication/authentication.dart';

class ProfileController extends ControllerMVC {
  factory ProfileController() => _this ??= ProfileController._();
  ProfileController._();
  static ProfileController? _this;

  Future<int?> retrieveReputation() {
    String? currEmail = retrieveCurrUser()?.email;
    return getReputationScore(currEmail!);
  }

  Future<String?> retrieveUserName() {
    String? currEmail = retrieveCurrUser()?.email;
    return getUserName(currEmail!);
  }
}
