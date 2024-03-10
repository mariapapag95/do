import 'package:flutter/material.dart';
import 'package:do_project/state/month_state.dart';
import 'package:do_project/task_model.dart';
import 'package:do_project/widgets/spacers.dart';

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
        padding:const  EdgeInsets.all(
          Spacers.xsmallSize,
        ),
        decoration: BoxDecoration(
          color: day.isInCurrentMonth
              ? Theme.of(context).splashColor
              : Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(Spacers.smallSize),
          border: day.day == monthState.today.day &&
                  monthState.displayDate.month == monthState.today.month
              ? Border.all(
                  color: Theme.of(context).highlightColor,
                )
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
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).shadowColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
