import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/tasks_widget.dart';

import '../../common_widgets/notched_bottom_navigation_bar.dart';
import '../../design_system/design_system.dart';
import '../../design_system/primitives/color_system.dart';
import '../../design_system/primitives/icon_system.dart';
import '../../models/agent.dart';
import '../../services/networking/endpoints.dart';
import '../../services/networking/networking_service.dart';
import '../../services/networking/request_body.dart';
import '../../services/storage/shared_preferences_service.dart';
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
  late Future<void> futureUser;

  Agent? agent;

  String agentName = '';

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

  Future<void> getAgentProfile() async {
    var email = await SharedPreferenceService().getValue(agentEmail);
    if (email != null) {
      var response = await HttpService().doPost(
          path: Endpoints.getAgentProfile(),
          body: jsonEncode(RequestBody.getAgentProfileBody(email: email)));

      if (response.data != null) {
        agent = Agent.fromJson(response.data['UserList'][0]['User'],
            isManager: response.data['UserList'][0]['IsManager']);
      }
    }
  }

  @override
  initState() {
    super.initState();
    futureUser = getAgentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar,
      body: FutureBuilder(
        future: futureUser,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorSystem.primary,
                ),
              );
            case ConnectionState.done:
              return ListView(
                children: [
                  TasksWidget(
                    agent: agent,
                    agentName: widget.agentName,
                    showGraphs: true,
                  )
                ],
              );
          }
        },
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
