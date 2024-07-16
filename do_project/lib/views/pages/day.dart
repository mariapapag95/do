import 'package:do_project/state/view_state.dart';
import 'package:do_project/views/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:do_project/state/day_state.dart';
import 'package:intl/intl.dart';
import 'package:do_project/data/task_model.dart';
import 'package:states_rebuilder/scr/state_management/extensions/reactive_model_x.dart';

class Day extends StatelessWidget {
  const Day({super.key});

  @override
  Widget build(BuildContext context) {
    return day.rebuild(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 80,
                width: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      DateFormat('MMM').format(dayState.today).toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        height: 0.9,
                      ),
                    ),
                    Text(
                      DateFormat('d').format(dayState.today).toUpperCase(),
                      style: TextStyle(
                        fontSize: 35,
                        color: Theme.of(context).colorScheme.onPrimary,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      DateFormat('y').format(dayState.today).toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        height: 0.9,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (Task task in dayState.toDo) Text('•  ${task.label}'),
                ],
              ),
            ],
          ),
          Spacers.medium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (Task task in viewState.tasks) Text('•  ${task.label}'),
            ],
          ),
        ],
      ),
    );
  }
}
