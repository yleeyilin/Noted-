import 'package:python_channel/python_channel.dart';

double retrieveScore(String article1, String article2) {
  PythonChannelPlugin.bindHost(
      name: 'host',
      debugPyPath: '/Users/leeyilin/Noted-/noted/lib/model/recommendation/topicmodelling.py', 
      releasePath: 'executable/topicmodelling.exe');
}