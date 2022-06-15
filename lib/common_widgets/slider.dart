import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/common_widgets/page_indicator.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class SliderDynamic extends StatefulWidget {
  SliderDynamic({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  _SliderDynamicState createState() => _SliderDynamicState();
}

class _SliderDynamicState extends State<SliderDynamic> {
  late PageController controller;

  GlobalKey<PageContainerState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      // color: Colors.red,
      margin: EdgeInsets.only(top: 20, bottom: 0),
      child: PageIndicatorContainer(
        key: key,
        shape: IndicatorShape.roundRectangleShape(
            cornerSize: Size.square(6), size: Size(20, 4)),
        child: PageView(
          children: <Widget>[
            // _SliderWidget(name: widget.name),
            // _SliderWidget(name: widget.name),
            // _SliderWidget(name: widget.name)
            // Text('4'),
          ],
          controller: controller,
          reverse: false,
        ),
        align: IndicatorAlign.bottom,
        indicatorColor: Color(0xffD6D9E0),
        indicatorSelectorColor: Color(0xffB5AFF9),
        length: 3,
        indicatorSpace: 10.0,
      ),
    );
  }
}


