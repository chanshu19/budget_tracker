import 'package:hive/hive.dart';

class DbHelper {
  late Box box;
  DbHelper() {
    openBox();
  }

  void openBox() {
    box = Hive.box("budget");
  }

  Future addData(int? amount, DateTime date, String note, String type) async {
    var value = {'amount': amount, 'date': date, 'note': note, 'type': type};
    box.add(value);
  }

  Future<Map> fetch(){
    if(box.values.isEmpty){
      return Future.value({});
    }
    else{
      return Future.value(box.toMap());
    }
  }
}
