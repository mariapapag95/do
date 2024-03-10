import 'package:flutter/material.dart';
import 'package:do_project/state/view_state.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: view.rebuild(
          () => Column(
            children: [
              for (Widget section in viewState.sections)
                Expanded(
                  child: GestureDetector(
                    onTap: () => viewState.openView(section),
                    onDoubleTap: () => viewState.closeView(section),
                    onVerticalDragUpdate: (details) {
                      int sensitivity = 8;
                      if (details.delta.dy > sensitivity) {
                        // Down Swipe

                      } else if (details.delta.dy < -sensitivity) {
                        // Up Swipe
                        viewState.showAddTaskModal(context);
                      }
                    },
                    child: section,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
