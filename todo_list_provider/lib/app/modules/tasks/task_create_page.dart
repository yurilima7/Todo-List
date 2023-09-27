// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/widgets/calendar_button.dart';

class TaskCreatePage extends StatelessWidget {
  final TaskCreateController _controller;

  const TaskCreatePage({
    Key? key,
    required TaskCreateController controller,
  }) : _controller = controller, super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: context.primaryColor,
        label: const Text(
          'Salvar task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar atividade',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),

              const SizedBox(height: 30,),

              TodoListField(label: ''),

              const SizedBox(height: 20,),

              const CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
