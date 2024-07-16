import 'package:do_project/state/view_state.dart';
import 'package:do_project/data/task_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

var day = RM.inject(() => DayState());
var dayState = day.state;

class DayState {
  DateTime today = DateTime.now();

  List<Task> toDo = viewState.allTasks
      .where((Task task) => task.date?.day == DateTime.now().day)
      .toList();
}
