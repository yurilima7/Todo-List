
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_page.dart';

class TasksModule extends TodoListModule{
  TasksModule() : super(
    bindings: [
      ChangeNotifierProvider(create: (context) => TaskCreateController(),)
    ],

    routers: {
      '/task/create':(context) => TaskCreatePage(controller: context.read(),)
    }
  );
  
}