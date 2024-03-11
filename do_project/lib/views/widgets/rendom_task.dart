import 'package:flutter/material.dart';
import 'package:do_project/state/view_state.dart';
import 'package:do_project/data/task_model.dart';
import 'package:do_project/views/widgets/spacers.dart';

class RandomTask extends StatelessWidget {
  const RandomTask({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(viewState.randomTask.label),
        IconButton(
          icon: const Icon(Icons.thumb_down_alt_sharp, size: Spacers.largeSize,),
          onPressed: () => viewState.getRandomTask(),
        )
      ],
    );
  }
}
