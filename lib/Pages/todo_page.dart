import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/Data/database.dart';
import 'package:todo_app/Pages/button_block.dart';
import 'package:todo_app/Pages/todo_list.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {

  final _myBox = Hive.box('mybox');
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    //first time creating the app
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();
  void checkBoxTapped(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }
  void saveNewTask(){
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }
  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);

    });
    db.updateDatabase();
  }
  void createNewTask(){
   showDialog(context: context, builder: (context){
     return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
       backgroundColor: Colors.deepPurple[100],
       content: Padding(
         padding: const EdgeInsets.only(top:8,bottom: 0, left: 0, right: 0),
         child: Container(
             height: 50,
             child: TextField(
               controller: _controller,
               decoration: InputDecoration(
                 labelText: "Enter your task here",
                 border: OutlineInputBorder(),
               ),
             )
         ),
       ),
       actions: [
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Buttons(name: "Cancel", on_pressed: () => Navigator.of(context).pop()),
             Buttons(name: "Save", on_pressed: saveNewTask)
           ],
         )
       ],
     );
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple[300],centerTitle: true,elevation: 0,
        title: Text("T O  D O",style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: Colors.deepPurple[100],
      floatingActionButton: FloatingActionButton(onPressed: createNewTask,
      child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount:db.todoList.length,
        itemBuilder:  (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
            deleteCurrentTask: (context) => deleteTask(index),
          );
        }
      ),
    );
  }
}
