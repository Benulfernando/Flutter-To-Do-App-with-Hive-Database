import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext) ? deleteCurrentTask;
  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteCurrentTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 2),
      child:Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteCurrentTask,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
              )
            ]
        ),
        child:Container(
          padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.deepPurple[300],
          borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Checkbox(value: taskCompleted, onChanged: onChanged),
            Text(taskName, style: TextStyle(
              fontSize: 20,
              color: Colors.grey[200],
              decoration: (taskCompleted? TextDecoration.lineThrough : TextDecoration.none),
            ),)
          ],
        ),
    ),
      ),
    );
  }
}
