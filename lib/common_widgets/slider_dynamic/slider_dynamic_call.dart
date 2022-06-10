import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:salesforce_spo/common_widgets/slider_dynamic/slider_dynamic_content.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';

import 'package:salesforce_spo/design_system/primitives/landing_images.dart';
import 'package:salesforce_spo/utils/constants.dart';

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
            _SliderWidget(name: widget.name),
            _SliderWidget(name: widget.name),
            _SliderWidget(name: widget.name)
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

class _SliderWidget extends StatelessWidget {
  const _SliderWidget({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          margin: EdgeInsets.only(top: 10.0, bottom: 0),
          decoration: BoxDecoration(),
          child: Column(children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffD6D9E0).withOpacity(0.5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Color(0xffFF9B90),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "May",
                          style: TextStyle(
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                              color: Colors.white),
                        ),
                        Text(
                          '25',
                          style: TextStyle(
                              fontSize: SizeSystem.size20,
                              fontFamily: kRubik,
                              color: Colors.white),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "call alert ",
                              style: const TextStyle(
                                color: Color(0xff2D3142),
                                height: 1.4,
                                fontSize: SizeSystem.size18,
                                fontFamily: kRubik,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                                text: name,
                                style: const TextStyle(
                                    color: Color(
                                      0xff8C80F8,
                                    ),
                                    height: 1.4,
                                    fontSize: SizeSystem.size18,
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.bold))
                          ])),
                      const Text(
                        'ask for Warrenty',
                        style: TextStyle(
                          color: Color(0xff2D3142),
                          fontSize: SizeSystem.size16,
                          fontFamily: kRubik,
                          height: 1.4,
                        ),
                      ),
                      const Text(
                        'purchase',
                        style: TextStyle(
                          color: Color(0xff2D3142),
                          fontSize: SizeSystem.size16,
                          height: 1.4,
                          fontFamily: kRubik,
                        ),
                      ),
                      const Text('View Task',
                          style: TextStyle(
                              color: Color(
                                0xff8C80F8,
                              ),
                              fontSize: SizeSystem.size16,
                              height: 1.4,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ]),
            )
          ]),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(right: 40, top: 0.0),
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 22,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  color: Color(0xffB5AFF9).withOpacity(0.3),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  offset: const Offset(
                    0.0,
                    8.0,
                  ),
                )
              ],
            ),
            // ignore: prefer_const_constructors
            child: Text(
              "TODAY",
              style: const TextStyle(
                  color: Color(0xff2D3142),
                  fontSize: SizeSystem.size12,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
                // color: Colors.red,
                margin: EdgeInsets.only(right: 4, bottom: 18),
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(
                  LandingImages.personSlider, fit: BoxFit.cover, height: 102,
                  // color: ColorSystem.black,
                )))
      ],
    );
  }
}
