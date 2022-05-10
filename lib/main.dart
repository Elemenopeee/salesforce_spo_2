import 'dart:developer';
import 'dart:ui';

import 'package:azure_ad_authentication/azure_ad_authentication.dart';
import 'package:azure_ad_authentication/exeption.dart';
import 'package:azure_ad_authentication/model/user_ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/notched_bottom_navigation_bar.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/customer_lookup_widget.dart';
import 'package:salesforce_spo/presentation/tabs/home_tab.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late MsalMobile msal;

  static const String _authority =
      "https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize";

  static const String _clientId = "88641257-66b0-4343-97c3-b78bf111e27a";

  String _output = 'NONE';
  static const List<String> kScopes = [
    "https://graph.microsoft.com/user.read",
    "https://graph.microsoft.com/Calendars.ReadWrite",
  ];

  Future<void> _acquireToken() async {
    await getResult();
  }

  Future<String> getResult({bool isAcquireToken = true}) async {
    AzureAdAuthentication pca = await intPca();
    String? res;
    UserAdModel? userAdModel;
    try {
      if (isAcquireToken) {
        userAdModel = await pca.acquireToken(scopes: kScopes);
        print(userAdModel?.id);
        log(userAdModel!.accessToken! + userAdModel.accessToken!);
        // userAdModel.
      } else {
        userAdModel = await pca.acquireTokenSilent(scopes: kScopes);
      }
    } on MsalUserCancelledException {
      res = "User cancelled";
    } on MsalNoAccountException {
      res = "no account";
    } on MsalInvalidConfigurationException {
      res = "invalid config";
    } on MsalInvalidScopeException {
      res = "Invalid scope";
    } on MsalException {
      res = "Error getting token. Unspecified reason";
    }

    setState(() {
      _output = (userAdModel?.toJson().toString() ?? res)!;
    });
    return (userAdModel?.toJson().toString() ?? res)!;
  }

  Future<AzureAdAuthentication> intPca() async {
    return await AzureAdAuthentication.createPublicClientApplication(
        clientId: _clientId, authority: _authority);
  }

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
                IconSystem.notification,
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
            width: 20,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar,
      body: const TabHome(),
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
            onPressed: _acquireToken,
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
            try{
              await launchUrlString('salesforce1://sObject/0018B000002ZDfbQAG/view');
            }
            catch (e){
              print(e);
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
