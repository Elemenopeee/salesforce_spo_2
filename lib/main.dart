import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/notched_bottom_navigation_bar.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/customer_lookup_widget.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salesforce SPO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  get getAppBar => AppBar(
        toolbarHeight: 80,
        leadingWidth: double.infinity,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                IconSystem.menu,
                color: Color(0xFF888888),
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 30,
              ),
              SvgPicture.asset(
                IconSystem.chat,
                color: Color(0xFF888888),
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          "HOME",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                IconSystem.notifications,
                width: 30,
                height: 30,
                color: Color(0xFF888888),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 05,
          ),
          SvgPicture.asset(
            IconSystem.search,
            width: 30,
            height: 30,
            color: Color(0xFF888888),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar,
      body: const SizedBox.shrink(),
      bottomNavigationBar: NotchedBottomNavigationBar(
        actions: [
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              showModalBottomSheet(
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
            ),
          ),
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: SvgPicture.asset(
              IconSystem.more,
              width: 24,
              height: 24,
            ),
          ),
        ],
        centerButton: FloatingActionButton(
          backgroundColor: ColorSystem.primary,
          onPressed: () async {
            var response = await HttpService().doGet(path: 'http://demo2572955.mockable.io//testredirecturl');

            if(response.data != null){
              await launchUrlString(response.data['url']);
            }

          },
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





