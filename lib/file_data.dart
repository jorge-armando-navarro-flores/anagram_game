import 'package:flutter/services.dart' show rootBundle;

class FileData{
  final String path;
  FileData(this.path);

  Future getData() async{
    String data = await rootBundle.loadString(path);
    return data;
  }
}