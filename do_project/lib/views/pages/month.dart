import 'package:flutter/material.dart';
import 'package:do_project/state/month_state.dart';
import 'package:intl/intl.dart';
import 'package:do_project/views/widgets/calendar_card.dart';
import 'package:do_project/views/widgets/spacers.dart';
import 'package:states_rebuilder/scr/state_management/extensions/reactive_model_x.dart';

class Month extends StatelessWidget {
  const Month({super.key});

  @override
  Widget build(BuildContext context) {
    return month.rebuild(
      () => Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () => monthState.previousMonth(),
                ),
                Text(
                  DateFormat('MMMM y')
                      .format(monthState.displayDate)
                      .toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () => monthState.nextMonth(),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity == 0) {
                  return; // user have just tapped on screen (no dragging)
                }

                if (details.primaryVelocity?.compareTo(0) == -1) {
                  monthState.nextMonth();
                } else {
                  monthState.previousMonth();
                }
              },
              child: GridView.count(
                padding: const EdgeInsets.all(Spacers.smallSize),
                childAspectRatio: 1.25,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 7,
                children: [
                  for (CalendarCardItem day in monthState.allCalendarDays)
                    CalendarCard(day: day),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
