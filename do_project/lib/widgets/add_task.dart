import 'package:flutter/material.dart';
import 'package:do_project/state/day_state.dart';
import 'package:do_project/state/view_state.dart';
import 'package:do_project/task_model.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: viewState.taskTextFieldController,
          maxLines: 3,
          autocorrect: false,
          autofocus: true,
          onTapOutside: (PointerDownEvent event) =>
              viewState.taskTextFieldFocus.unfocus(),
          // Will this dismiss keyboard automatically?
          decoration: const InputDecoration(
            hintText: 'Task',
          ),
        ),
        TextFormField(
          controller: viewState.detailsTextFieldController,
          maxLines: 3,
          autocorrect: false,
          autofocus: true,
          onTapOutside: (PointerDownEvent event) =>
              viewState.detailsTextFieldFocus.unfocus(),
          // Will this dismiss keyboard automatically?
          decoration:const  InputDecoration(
            hintText: 'Details',
          ),
        ),
        DatePickerDialog(
          initialDate: dayState.today,
          firstDate: dayState.today,
          lastDate: dayState.today.add(const Duration(days: 365)),
          fieldHintText: 'Date',
        ),
        TimePickerDialog(initialTime: TimeOfDay.now()),
        IconButton(
          onPressed: () => viewState.addTask(
            Task(
              id: 1,
              label: viewState.taskTextFieldController.text,
              details: viewState.detailsTextFieldController.text,
              createdOn: DateTime.now(),
            ),
          ),
          icon:const  Icon(Icons.add_circle),
        )
      ],
    );
  }
}
