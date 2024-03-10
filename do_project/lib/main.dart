import 'package:flutter/material.dart';
import 'package:do_project/pages/all.dart';
import 'package:do_project/state/view_state.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  viewState.getTasks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: viewState.theme,
      home: const All(),
    );
  }
}
