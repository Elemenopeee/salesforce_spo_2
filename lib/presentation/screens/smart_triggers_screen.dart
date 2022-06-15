import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/tasks_widget.dart';

import '../../common_widgets/notched_bottom_navigation_bar.dart';
import '../../design_system/design_system.dart';
import '../../design_system/primitives/color_system.dart';
import '../../design_system/primitives/icon_system.dart';
import '../../utils/constants.dart';
import '../intermediate_widgets/customer_lookup_widget.dart';

class SmartTriggerScreen extends StatefulWidget {
  final String agentName;

  const SmartTriggerScreen({Key? key, required this.agentName})
      : super(key: key);

  @override
  State<SmartTriggerScreen> createState() => _SmartTriggerScreenState();
}

class _SmartTriggerScreenState extends State<SmartTriggerScreen> {
  get getAppBar => AppBar(
        toolbarHeight: kToolbarHeight,
        leadingWidth: double.infinity,
        backgroundColor: ColorSystem.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SMART TRIGGERS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: kRubik,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar,
      body: ListView(
        children: [
          TasksWidget(agentName: widget.agentName, showGraphs: true,)
        ],
      ),
      bottomNavigationBar: NotchedBottomNavigationBar(
        actions: [
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              showModalBottomSheet(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.9),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomerLookupWidget();
                  },
                  backgroundColor: Colors.transparent);
            },
            icon: SvgPicture.asset(
              IconSystem.user,
              width: 24,
              height: 24,
              color: ColorSystem.primary,
            ),
          ),
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: SvgPicture.asset(
              IconSystem.feed,
              width: 24,
              height: 24,
              color: ColorSystem.primary,
            ),
          ),
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: SvgPicture.asset(
              IconSystem.sparkle,
              width: 24,
              height: 24,
              color: ColorSystem.secondary,
            ),
          ),
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: null,
            icon: SvgPicture.asset(
              IconSystem.more,
              width: 24,
              height: 24,
              color: ColorSystem.primary,
            ),
          ),
        ],
        centerButton: FloatingActionButton(
          backgroundColor: ColorSystem.primary,
          onPressed: () async {},
          child: SvgPicture.asset(
            IconSystem.plus,
            width: 24,
            height: 24,
            color: ColorSystem.white,
          ),
        ),
      ),
    );
  }
}
