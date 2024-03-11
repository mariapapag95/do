import 'package:flutter/material.dart';
import 'package:do_project/state/month_state.dart';
import 'package:do_project/data/task_model.dart';
import 'package:do_project/views/widgets/spacers.dart';

class CalendarCardItem {
  CalendarCardItem({
    required this.day,
    required this.isInCurrentMonth,
    this.tasks,
  });

  int day;
  bool isInCurrentMonth;
  List<Task>? tasks;
}

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.day,
  });

  final CalendarCardItem day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Spacers.xsmallSize,
        left: Spacers.xsmallSize,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          Spacers.xsmallSize,
        ),
        decoration: BoxDecoration(
          color: day.isInCurrentMonth
              ? Theme.of(context).secondaryHeaderColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Spacers.smallSize),
          border: day.day == monthState.today.day &&
                  monthState.displayDate.month == monthState.today.month
              ? Border.all()
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              day.day.toString(),
              style: TextStyle(
                color: day.isInCurrentMonth
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).splashColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
