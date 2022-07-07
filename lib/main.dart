import 'package:azure_ad_authentication/azure_ad_authentication.dart';
import 'package:azure_ad_authentication/exeption.dart';
import 'package:azure_ad_authentication/model/user_ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salesforce_spo/models/agent.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/create_new_task_widget.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/customer_lookup_widget.dart';
import 'package:salesforce_spo/presentation/screens/smart_triggers_screen.dart';
import 'package:salesforce_spo/presentation/tabs/home_tab.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';
import 'package:salesforce_spo/utils/constants.dart';

import 'common_widgets/notched_bottom_navigation_bar.dart';
import 'common_widgets/tgc_app_bar.dart';
import 'design_system/design_system.dart';

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
      SharedPreferenceService()
          .setKey(key: agentEmail, value: '${userAdModel?.mail}');

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
    return GetMaterialApp(
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: TGCAppBar(
        label: 'HOME',
      ),
      body: const TabHome(),
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
          // IconButton(
          //   focusColor: Colors.transparent,
          //   splashColor: Colors.transparent,
          //   onPressed: () {},
          //   icon: SvgPicture.asset(
          //     IconSystem.feed,
          //     width: 24,
          //     height: 24,
          //     color: ColorSystem.primary,
          //   ),
          // ),
          // IconButton(
          //   focusColor: Colors.transparent,
          //   splashColor: Colors.transparent,
          //   onPressed: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (BuildContext context) {
          //       return SmartTriggerScreen(
          //         agentName: userAdModel?.givenName != null
          //             ? '${userAdModel!.givenName}\'s'
          //             : 'My',
          //       );
          //     }));
          //   },
          //   icon: SvgPicture.asset(
          //     IconSystem.sparkle,
          //     width: 24,
          //     height: 24,
          //     color: ColorSystem.primary,
          //   ),
          // ),
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
          onPressed: () {},
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
