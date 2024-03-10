import 'package:do_project/state/view_state.dart';
import 'package:do_project/task_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

var day = RM.inject(() => DayState());
var dayState = day.state;

class DayState {
  DateTime today = DateTime.now();

  List<Task> toDo = viewState.tasks
      .where(
        (Task task) =>
            task.date == null || task.date?.day == DateTime.now().day,
      )
      .toList();
}
