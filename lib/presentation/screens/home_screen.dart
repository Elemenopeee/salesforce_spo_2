import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/profile_container.dart';
import 'package:salesforce_spo/common_widgets/tgc_app_bar.dart';
import 'package:salesforce_spo/presentation/screens/smart_triggers_screen.dart';
import 'package:salesforce_spo/presentation/tabs/custom_tab_bar.dart';

import '../../common_widgets/notched_bottom_navigation_bar.dart';
import '../../design_system/design_system.dart';
import '../intermediate_widgets/customer_lookup_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late TabController teamsTabController;


  @override
  initState(){
    super.initState();
    teamsTabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.scaffoldBackgroundColor,
      appBar: TGCAppBar(
        label: 'HOME',
      ),
      body: ListView(
        children: [
          const ProfileContainer(agentName: 'Ankit'),
          CustomTabBarExtended(
            padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size16),
            height: 48,
            containerColor: Colors.grey.withOpacity(0.1),
            containerBorderRadius: 10.0,
            tabBorderRadius: 10.0,
            tabOneName: "Browsing History",
            tabTwoName: "Buy Again",
            tabThreeName: "Cart",
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(
                  0.0,
                  1.0,
                ),
                blurRadius: 2,
                spreadRadius: 2,
              )
            ],
            tabController: teamsTabController,
            tabColor: Colors.white,
            labelColor: Colors.black,
            unSelectLabelColor: Colors.grey,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
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
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const SmartTriggerScreen(
                  agentName: 'Ankit\'s',
                );
              }));
            },
            icon: SvgPicture.asset(
              IconSystem.sparkle,
              width: 24,
              height: 24,
              color: ColorSystem.primary,
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
