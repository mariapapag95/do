import 'package:do_project/data/sqflite_service.dart';
import 'package:do_project/views/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:do_project/views/pages/day.dart';
import 'package:do_project/views/pages/month.dart';
import 'package:do_project/views/pages/week.dart';
import 'package:do_project/views/styles.dart';
import 'package:do_project/data/task_model.dart';
import 'package:do_project/views/widgets/rendom_task.dart';
import 'package:sqflite/sqflite.dart';
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
  late Database _database;

  TextEditingController labelTextFieldController = TextEditingController();
  TextEditingController detailsTextFieldController = TextEditingController();

  FocusNode labelTextFieldFocus = FocusNode();
  FocusNode detailsTextFieldFocus = FocusNode();

  DateTime? taskDate;
  DateTime? taskTime;

  Future<void> initializeDatabase() async {
    try {
      _database = await SqliteService.openSQLDatabase();
    } catch (e) {
      // Handle the error as needed
      debugPrint('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> loadTasks() async {
    try {
      await initializeDatabase();

      final List<Map<String, Object?>> maps = await _database.query('Tasks');

      tasks = List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      });

      debugPrint(tasks.toString());
      view.notify();
    } catch (e) {
      // Handle the error as needed
      debugPrint('Error loading tasks: $e');
      rethrow;
    }
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

  Future<void> addTask(Task task) async {
    await _database.insert(
      'Tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    tasks.add(task);
    view.notify();
  }

  Future<void> updateTask(Task updatedTask) async {
    await _database.update(
      'Tasks',
      updatedTask.toMap(),
      where: 'id = ?',
      whereArgs: [updatedTask.id],
    );
    // find task and update it
  }

  Future<void> deleteTask(int taskId) async {
    await _database.delete(
      'Tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  void openView(Widget selectedView) {
    sections = <Widget>[selectedView];
    view.notify();
  }

  void closeView() {
    sections = <Widget>[
      const Day(),
      const Week(),
      const Month(),
    ];
    view.notify();
  }

  void showAddTaskModal(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) => const AddTask(),
        isScrollControlled: true,
      );

  void showRandomTask(BuildContext context) {
    // getTasks(); //refresh tasks
    getRandomTask();
    showDialog(
      context: context,
      builder: (context) => RandomTask(
        task: randomTask,
      ),
    );
  }
}
