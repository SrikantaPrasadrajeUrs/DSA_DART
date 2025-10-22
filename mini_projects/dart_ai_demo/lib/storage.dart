import 'dart:convert';
import 'dart:io';

class Storage{
  final String path;

  Storage(this.path);

  void save(String input, String text){
    final file = File(path);
    if(!file.existsSync()){
      file.createSync(recursive: true);
    }
    String data = file.readAsStringSync();
    if(data.length==0) data = "[]";
    List<Map<String,dynamic>> historyData = List<Map<String,dynamic>>.from(jsonDecode(data));
    historyData.add({"input": input, "output": text});
    file.writeAsStringSync(jsonEncode(historyData));
  }

  Future<List> read() async{
    final file = File(path);
    return await file.readAsString().then((data)=>jsonDecode(data));
  }

}