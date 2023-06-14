import 'package:noted/model/query/nusmods.dart';
import 'package:noted/model/query/createNode.dart';

Future<void> createCourseNodesFromNUSMODS() async {
  try {
    final List<String> moduleCodes = await fetchNUSMODS();

    for (String moduleCode in moduleCodes) {
      await createCourseNode(moduleCode);
    }
  } catch (e) {
    print('Error creating course nodes: $e');
  }
}