import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bidirectional_listview/bidirectional_listview.dart';
import 'package:do_project/state/week_state.dart';
import 'package:states_rebuilder/scr/state_management/extensions/reactive_model_x.dart';

class Week extends StatelessWidget {
  const Week({super.key});

  @override
  Widget build(BuildContext context) {
    return week.rebuild(
      () => BidirectionalListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => Container(
          color: Theme.of(context).colorScheme.primary,
          height: double.infinity,
          width: 2,
        ),
        negativeItemCount: weekState.today.day,
        itemBuilder: (BuildContext context, int index) {
          bool isToday = index == 0;
          DateTime day = DateTime(weekState.today.year, weekState.today.month,
              weekState.today.day + index);
          return SizedBox(
            width: (MediaQuery.of(context).size.width) /
                (weekState.isWeekdayExpanded ? 1 : 7),
            child: Column(
              children: [
                Text(
                  DateFormat('E').format(day).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('d').format(day),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isToday
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).hintColor,
                    fontWeight: isToday ? FontWeight.w900 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
