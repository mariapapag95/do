import 'package:do_project/state/view_state.dart';
import 'package:do_project/data/task_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:do_project/state/day_state.dart';

var week = RM.inject(() => WeekState());
var weekState = week.state;

class WeekState {
  DateTime today = DateTime.now();

  DateTime get monthEnd => DateTime(today.year, today.month + 1, 0);
  int firstDayOfMonth = 0;

  List<Task> get toDo => viewState.allTasks
      .where((Task task) =>
          (task.date ?? DateTime.now()).isAtSameMomentAs(thisWeek.first) ||
          (task.date ?? DateTime.now()).isAtSameMomentAs(thisWeek.last) ||
          (task.date ?? DateTime.now()).isAfter(thisWeek.first) &&
              (task.date ?? DateTime.now()).isBefore(thisWeek.last))
      .toList();

  bool isWeekdayExpanded = false;

  // void expandToday () {
  //   thisWeek.length == 1 ?
  // }

  List<DateTime> get thisWeek {
    List<DateTime> days = List.generate(
      monthEnd.day - today.day + 1,
      (index) => DateTime(today.year, today.month, today.day + index),
    );
    if (days.length < 7) {
      days.addAll(
        List.generate(
          7 - days.length,
          (index) => DateTime(
            (weekState.today.month == 12
                ? weekState.today.year + 1
                : weekState.today.year),
            weekState.today.month + 1,
            firstDayOfMonth + index,
          ),
        ),
      );
    }
    return days;
  }

  int get weekStart =>
      dayState.today.day -
      (dayState.today.weekday == 7 ? 0 : dayState.today.weekday);
}
