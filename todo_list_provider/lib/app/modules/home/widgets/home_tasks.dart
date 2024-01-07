import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(
            height: 20,
          ),

          Selector<HomeController, String>(
            builder: (context, value, child) => Text(
              'TASK\'S $value',
              style: context.titleStyle,
            ),

            selector: (context, controller) {
              return controller.filterSelected.description;
            }
          ),

          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                    (controller) => controller.filteredTasks)
                .map(
                  (t) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,

                    confirmDismiss: (direction) => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Deseja deletar a task?'),

                        content: const Text('Esta tarefa será deletada'),

                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancelar'),
                          ),

                          TextButton(
                            onPressed: () {
                              context.read<HomeController>().deleteTask(t.id);
                              Navigator.pop(context, false);
                            },
                               
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),

                    background: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      
                      child: const SizedBox(
                        child: Icon(Icons.delete, color: Colors.redAccent,),
                      ),
                    ),

                    child: Task(
                      taskModel: t,
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
