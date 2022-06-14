import 'package:flutter/material.dart';

import '../utils/enums/circle_painter.dart';
import '../utils/enums/oval_painter.dart';
import '../utils/enums/rounded_rectangle_painter.dart';

class PageIndicator extends StatefulWidget {
  final Color color;

  final Color selectedColor;

  final int length;

  final double indicatorSpace;

  final IndicatorShape indicatorShape;

  final IndicatorAlign align;

  final bool reverse;

  final double currentPage;
  final double initialPage;

  const PageIndicator({
    Key? key,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    required this.length,
    required this.currentPage,
    this.initialPage = 0,
    this.indicatorSpace = 5.0,
    this.indicatorShape = IndicatorShape.defaultCircle,
    this.align = IndicatorAlign.bottom,
    this.reverse = false,
  }) : super(key: key);

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter? indicatorPainter;

    IndicatorShape shape = widget.indicatorShape;

    bool reverse = widget.reverse;

    final page = widget.currentPage;

    if (shape is OvalShape) {
      indicatorPainter = OvalPainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        size: shape.size,
      );
    } else if (shape is RoundRectangleShape) {
      indicatorPainter = RRectPainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        size: shape.size,
        cornerSize: shape.cornerSize,
      );
    } else if (shape is CircleShape) {
      indicatorPainter = CirclePainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        radius: shape.size / 2,
      );
    }

    return IgnorePointer(
      child: RotatedBox(
        quarterTurns: reverse ? 2 : 0,
        child: CustomPaint(
          child: Container(
            height: shape.height,
          ),
          size: Size.fromHeight(shape.height),
          painter: indicatorPainter,
        ),
      ),
    );
  }
}

abstract class IndicatorShape {
  const IndicatorShape._();

  static const defaultCircle = CircleShape(12.0);

  static const defaultRoundRectangle = RoundRectangleShape();

  static const defaultOval = OvalShape();

  factory IndicatorShape.circle({double size = 12.0}) {
    return CircleShape(size);
  }

  factory IndicatorShape.roundRectangleShape({
    Size size = const Size(12.0, 12.0),
    Size cornerSize = const Size.square(3),
  }) {
    return RoundRectangleShape(
      cornerSize: cornerSize,
      size: size,
    );
  }

  factory IndicatorShape.oval({Size size = const Size(12, 8)}) {
    return OvalShape(size: size);
  }

  double get height;

  double get width;
}

class CircleShape extends IndicatorShape {
  final double size;
  const CircleShape(this.size) : super._();

  @override
  double get height => size;

  @override
  double get width => size;
}

class RoundRectangleShape extends IndicatorShape {
  final Size size;
  final Size cornerSize;

  const RoundRectangleShape({
    this.size = const Size(12, 12),
    this.cornerSize = const Size.square(3),
  }) : super._();

  @override
  double get height => size.height;

  @override
  double get width => size.width;
}

class OvalShape extends IndicatorShape {
  final Size size;
  const OvalShape({
    this.size = const Size(12, 4),
  }) : super._();

  @override
  double get height => size.height;

  @override
  double get width => size.width;
}

enum IndicatorAlign {
  top,
  center,
  bottom,
}

class PageIndicatorContainer extends StatefulWidget {
  final Widget child;

  final int length;

  final EdgeInsets padding;

  final IndicatorAlign align;

  final IndicatorShape shape;

  final Color indicatorColor;

  final Color indicatorSelectorColor;

  final double indicatorSpace;

  const PageIndicatorContainer({
    Key? key,
    required this.child,
    required this.length,
    this.padding = const EdgeInsets.only(bottom: 0.0, top: 0.0),
    this.align = IndicatorAlign.bottom,
    this.indicatorColor = Colors.white,
    this.indicatorSelectorColor = Colors.grey,
    this.indicatorSpace = 8.0,
    this.shape = IndicatorShape.defaultCircle,
  }) : super(key: key);

  @override
  PageContainerState createState() => PageContainerState();
}

class PageContainerState extends State<PageIndicatorContainer> {
  double? currentPage;

  @override
  Widget build(BuildContext context) {
    if (widget.child is! PageView) {
      return widget.child;
    }

    double height = widget.shape.height;

    final initPage = pageView.controller.initialPage;

    final currentPage = this.currentPage ?? initPage.toDouble();

    Widget indicator = PageIndicator(
      length: widget.length,
      color: widget.indicatorColor,
      selectedColor: widget.indicatorSelectorColor,
      indicatorSpace: widget.indicatorSpace,
      indicatorShape: widget.shape,
      align: widget.align,
      reverse: pageView.reverse,
      currentPage: currentPage,
      initialPage: initPage.toDouble(),
    );

    var align = widget.align;

    if (align == IndicatorAlign.bottom) {
      indicator = Positioned(
        left: 0.0,
        right: 0.0,
        bottom:0.0,
        // here to change indicaor alignment
        height: height+10,
        // here to change indicaor alignment
        child: indicator,
      );
    } else if (align == IndicatorAlign.top) {
      indicator = Positioned(
        left: 0.0,
        right: 0.0,
        top: widget.padding.top,
        height: height,
        child: indicator,
      );
    } else if (align == IndicatorAlign.center) {
      indicator = Center(
        child: SizedBox(
          child: indicator,
          height: height,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          child: pageView,
          onNotification: _onScroll,
        ),
        indicator,
      ],
    );
  }

  PageView get pageView => widget.child as PageView;

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics is PageMetrics) {
      final PageMetrics metrics = notification.metrics as PageMetrics;
      currentPage = metrics.page;
      setState(() {});
    }
    return false;
  }

  void forceRefreshState() {
    setState(() {});
  }
}