import 'package:flutter/material.dart';
import 'package:do_project/state/day_state.dart';
import 'package:intl/intl.dart';
import 'package:do_project/task_model.dart';

class Day extends StatelessWidget {
  const Day({super.key});

  @override
  Widget build(BuildContext context) {
    return day.rebuild(
      () => Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).splashColor,
              ),
              height: 100,
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat('MMM').format(dayState.today).toUpperCase(),
                  ),
                  Text(
                    DateFormat('d').format(dayState.today).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    DateFormat('y').format(dayState.today).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (Task task in dayState.toDo) Text(task.label),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
