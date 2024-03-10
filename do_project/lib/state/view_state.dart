import 'package:flutter/material.dart';
import 'package:do_project/pages/day.dart';
import 'package:do_project/pages/month.dart';
import 'package:do_project/pages/week.dart';
import 'package:do_project/service/sqlite_service.dart';
import 'package:do_project/state/week_state.dart';
import 'package:do_project/styles.dart';
import 'package:do_project/task_model.dart';
import 'package:do_project/widgets/add_task.dart';
import 'package:do_project/widgets/rendom_task.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

var view = RM.inject(() => ViewState());
var viewState = view.state;

class ViewState {
  ThemeData theme = Styles().lightTheme;
  List<Widget> sections = [
    const Day(),
   const Week(),
    const Month(),
  ];

  List<Task> tasks = [];
  late Task randomTask;

  TextEditingController taskTextFieldController = TextEditingController();
  TextEditingController detailsTextFieldController = TextEditingController();
  TextEditingController dateTextFieldController = TextEditingController();
  TextEditingController timeTextFieldController = TextEditingController();

  FocusNode taskTextFieldFocus = FocusNode();
  FocusNode detailsTextFieldFocus = FocusNode();
  FocusNode dateTextFieldFocus = FocusNode();
  FocusNode timeTextFieldFocus = FocusNode();

  void getTasks() async {
    tasks = await SqliteService.getItems(); // Change to local JSON
    view.notify();
  }

  void getRandomTask() {
    randomTask = tasks
        .where((Task task) => task.date == null && task.time == null)
        .toList()
        .elementAt(
          int.parse(
            DateTime.now().millisecondsSinceEpoch.toString()[3],
          ),
        );
    view.notify();
  }

  void addTask(Task task) {
    // TODO: Add to data (json?/SQLite?)
    view.notify();
  }

  void openView(Widget selectedView) {
    if (selectedView.runtimeType == const Week().runtimeType) {
      weekState.weekdayExpanded = true;
    } else {
      sections = <Widget>[selectedView];
    }
    view.notify();
  }

  void closeView(Widget selectedView) {
    if (selectedView.runtimeType == const Week().runtimeType) {
      weekState.weekdayExpanded = false;
    } else {
      sections = <Widget>[
        const Day(),
        const Week(),
        const Month(),
      ];
    }
    view.notify();
  }

  void showAddTaskModal(BuildContext context) =>
      showModalBottomSheet(context: context, builder: (context) => const AddTask());

  void showRandomTask(BuildContext context) {
    getTasks(); //refresh tasks
    getRandomTask();
    showDialog(
      context: context,
      builder: (context) => RandomTask(
        task: randomTask,
      ),
    );
  }
}
