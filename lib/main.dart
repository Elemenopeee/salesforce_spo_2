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
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';
import 'package:salesforce_spo/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _acquireToken();
  runApp(const MyApp());
}

const String _authority =
    "https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize";
const String _clientId = "88641257-66b0-4343-97c3-b78bf111e27a";

String _output = 'NONE';
const List<String> kScopes = [
  "https://graph.microsoft.com/user.read",
  "https://graph.microsoft.com/Calendars.ReadWrite",
];

UserAdModel? userAdModel;

Future<void> _acquireToken() async {
  await getResult();
}

Future<String> getResult({bool isAcquireToken = true}) async {
  AzureAdAuthentication pca = await intPca();
  String? res;
  try {
    if (isAcquireToken) {
      userAdModel = await pca.acquireToken(scopes: kScopes);
      SharedPreferenceService().setKey(key: 'agent_email', value: '${userAdModel?.mail}');
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
  return (userAdModel?.toJson().toString() ?? res)!;
}

Future<AzureAdAuthentication> intPca() async {
  return await AzureAdAuthentication.createPublicClientApplication(
      clientId: _clientId, authority: _authority);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GC Customer Connect Sandbox',
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
  get getAppBar => AppBar(
        toolbarHeight: 80,
        leadingWidth: double.infinity,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "HOME",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: kRubik,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: getAppBar,
      body: TabHome(
        agentName: userAdModel?.givenName ?? 'there',
      ),
      bottomNavigationBar: NotchedBottomNavigationBar(
        actions: [
          IconButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              // showModalBottomSheet(
              //     isScrollControlled: true,
              //     context: context,
              //     builder: (BuildContext context) {
              //       return const CustomerLookupWidget();
              //     },
              //     backgroundColor: Colors.transparent);
            },
            icon: SvgPicture.asset(
              IconSystem.user,
              width: 24,
              height: 24,
              color: ColorSystem.white,
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
              color: ColorSystem.white,
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
              color: ColorSystem.white,
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
              color: ColorSystem.white,
            ),
          ),
        ],
        centerButton: FloatingActionButton(
          backgroundColor: ColorSystem.primary,
          onPressed: () async {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    snap: true,
                    initialChildSize: 0.9,
                    minChildSize: 0.9,
                    maxChildSize: 1.0,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return const CustomerLookupWidget();
                    },
                  );
                },
                backgroundColor: Colors.transparent);
          },
          child: SvgPicture.asset(
            IconSystem.user,
            width: 24,
            height: 24,
            color: ColorSystem.white,
          ),
        ),
      ),
    );
  }
}
