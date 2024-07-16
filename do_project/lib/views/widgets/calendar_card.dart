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
    bool isToday = day.day == monthState.today.day &&
        monthState.displayDate.month == monthState.today.month;

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
              ? Theme.of(context).colorScheme.primary.withOpacity(0.45)
              : Theme.of(context).colorScheme.primary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(Spacers.smallSize),
          border: isToday
              ? Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2.5,
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
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
