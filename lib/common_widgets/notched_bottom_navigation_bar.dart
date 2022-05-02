import 'package:flutter/material.dart';

import '../utils/bottom_navigation_bar_painter.dart';

class NotchedBottomNavigationBar extends StatelessWidget {
  final List<IconButton> actions;
  final FloatingActionButton centerButton;

  const NotchedBottomNavigationBar({
    Key? key,
    required this.actions,
    required this.centerButton,
  })  : assert(
          actions.length == 4,
          'The number of actions should always be 4',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: BottomNavigationBarPainter(),
            child: Center(
              heightFactor: 0.9,
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    actions[0],
                    actions[1],
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    actions[2],
                    actions[3],
                  ],
                ),
              ),
            ),
          ),
          Center(
            heightFactor: 0.25,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.17,
              height: MediaQuery.of(context).size.width * 0.17,
              child: FittedBox(
                child: centerButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
