import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel taskModel;
  final dateFormat = DateFormat('dd/MM/y');

  Task({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),

      margin: const EdgeInsets.symmetric(vertical: 5),

      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Checkbox(
            value: taskModel.finished,
            onChanged: (value) =>
                context.read<HomeController>().checkOrUncheckTask(taskModel),
          ),

          title: Text(
            taskModel.description,
            style: TextStyle(
              decoration: taskModel.finished ? TextDecoration.lineThrough : null,
            ),
          ),

          subtitle: Text(
            dateFormat.format(taskModel.dateTime),
            style: TextStyle(
              decoration: taskModel.finished ? TextDecoration.lineThrough : null,
            ),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1)
          ),
        ),
      ),
    );
  }
}
