import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {

    void updateSelectedDate(DateTime? selectedDate) {
      context.read<TaskCreateController>().selectedDate = selectedDate;
    }

    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 10 * 365));

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );

        updateSelectedDate(selectedDate);
      },

      borderRadius: BorderRadius.circular(30),

      child: Container(
        padding: const EdgeInsets.all(10),
    
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
    
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.today, color: Colors.grey,),
            const SizedBox(width: 10),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: context.titleStyle,
                  );
                } else {
                  return Text(
                    'SELECIONE UMA DATA',
                    style: context.titleStyle,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
