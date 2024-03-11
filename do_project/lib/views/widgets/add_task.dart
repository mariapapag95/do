import 'package:do_project/views/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:do_project/state/day_state.dart';
import 'package:do_project/state/view_state.dart';
import 'package:do_project/data/task_model.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dayState.today,
      firstDate: dayState.today,
      lastDate: dayState.today.add(const Duration(days: 365)),
      fieldHintText: 'Date',
    );

    if (picked != null && picked != viewState.taskDate) {
      viewState.taskDate = picked;
      view.notify();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    DateTime day = viewState.taskDate ?? DateTime.now();

    final TimeOfDay taskTimeAsTimeOfDay = TimeOfDay(
      hour: viewState.taskTime?.hour ?? 0,
      minute: viewState.taskTime?.minute ?? 0,
    );

    if (picked != null && picked != taskTimeAsTimeOfDay) {
      viewState.taskTime = DateTime(
        day.year,
        day.month,
        day.day,
        picked.hour,
        picked.minute,
      );
      view.notify();
    }
  }

  Widget textField({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    required int maxLines,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      autocorrect: false,
      autofocus: true,
      onTapOutside: (PointerDownEvent event) =>
          viewState.detailsTextFieldFocus.unfocus(),
      // Will this dismiss keyboard automatically?
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).focusColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).cardColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacers.largeSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            textField(
              controller: viewState.labelTextFieldController,
              maxLines: 1,
              focusNode: viewState.labelTextFieldFocus,
              hint: 'Task',
              context: context,
            ),
            Spacers.large,
            textField(
              controller: viewState.detailsTextFieldController,
              maxLines: 3,
              focusNode: viewState.detailsTextFieldFocus,
              hint: 'Details',
              context: context,
            ),
            Spacers.large,
            Theme(
              data: ThemeData(
                iconButtonTheme: IconButtonThemeData(
                  style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(30.0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () => _selectDate(context),
                  ),
                  Spacers.xlarge,
                  IconButton(
                    icon: const Icon(Icons.access_time_filled_outlined),
                    onPressed: () => _selectTime(context),
                  ),
                  Spacers.xlarge,
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () {
                      if (viewState.labelTextFieldController.text.isNotEmpty) {
                        viewState.addTask(
                          Task(
                            id: 0, // This value will automatically be populated by SQL
                            label: viewState.labelTextFieldController.text,
                            details: viewState.detailsTextFieldController.text,
                            date: null,
                            time: DateTime.now(),
                            createdOn: DateTime.now(),
                          ),
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
