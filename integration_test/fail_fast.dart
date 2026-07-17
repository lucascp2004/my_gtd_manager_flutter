import 'dart:convert';
import 'dart:io';
void main() async {
  final lines = stdin.transform(utf8.decoder).transform(LineSplitter());

  await for (final line in lines) {
    try {
      final jsonLine = jsonDecode(line);
      if (jsonLine is Map && jsonLine.containsKey('message')) {
        var time=((jsonLine["time"] as int)/1000).round();
        var timeStr = time.toString().padLeft(4,'0');
        print("$timeStr : ${jsonLine['message']}");
      }
      if (jsonLine is Map && jsonLine.containsKey('error')) {
        
        print(jsonLine['error']);
        print('''
            ## DEU RUIM
            ## DEU RUIM
            ## DEU RUIM
            ## DEU RUIM
            ## DEU RUIM
            ## DEU RUIM
''');
        exit(1);
      }
    } catch (e) {
      // If the line is not a valid JSON, just print it
      print(line);
    }
  }
}
