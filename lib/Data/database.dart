import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase{

  List todoList = [];

  final _myBox = Hive.box('mybox');

  //running this method first time ever opening this app
  void createInitialData(){
    todoList = [
      ["makeTutorial", false],
      ["Do Dishes", false]
    ];
  }

  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  void updateDatabase(){
    _myBox.put("TODOLIST", todoList);
  }
}