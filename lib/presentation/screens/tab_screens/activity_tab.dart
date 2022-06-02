import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/client_activity.dart';
import 'package:salesforce_spo/painter/line_dashed_painter.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../../../design_system/primitives/color_system.dart';
import '../../../design_system/primitives/landing_images.dart';
import '../../../design_system/primitives/music_icons_system.dart';
import '../../../design_system/primitives/size_system.dart';
import '../../../utils/constants.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  List<ClientActivity> activities = [];

  late Future<void> _futureActivity;

  Future<void> getClientActivity() async {
    var clientId = '0014M00001nv3BwQAI';
    var response =
        await HttpService().doGet(path: Endpoints.getClientActivity(clientId));

    for (var record in response.data['records']) {
      activities.add(ClientActivity.fromJson(record));
    }
  }

  @override
  initState() {
    super.initState();
    _futureActivity = getClientActivity();
  }

  String tenseDecider(String? activityDate) {
    var dateNow = DateTime.now();
    if (activityDate == null) {
      return ' has a task with ';
    }
    var activityDateTime = DateTime.parse(activityDate);
    if (activityDateTime.millisecondsSinceEpoch.toInt() <
        dateNow.millisecondsSinceEpoch.toInt()) {
      return ' had a task with ';
    } else {
      return ' has an upcoming task with ';
    }
  }

  String dateFormatter(String? activityDate) {
    if (activityDate == null) {
      return '--';
    } else {
      return DateFormat('MM-dd-yyyy').format(DateTime.parse(activityDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureActivity,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeSystem.size20,
                vertical: SizeSystem.size20,
              ),
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconSystem.feed,
                          width: SizeSystem.size20,
                          height: SizeSystem.size20,
                        ),
                        CustomPaint(
                          painter: LineDashedPainter(height: 58),
                        ),
                        const SizedBox(
                          height: SizeSystem.size48,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: SizeSystem.size20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activities[index].subject ?? '--',
                            style: const TextStyle(
                              color: ColorSystem.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: kRubik,
                            ),
                          ),
                          const SizedBox(
                            height: SizeSystem.size4,
                          ),
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: kRubik,
                                  fontSize: SizeSystem.size14,
                                ),
                                children: [
                                  TextSpan(
                                    text: activities[index]
                                            .clientActivityOwner
                                            ?.name ??
                                        '--',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  TextSpan(
                                      text: tenseDecider(
                                          activities[index].activityDate),
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  TextSpan(
                                    text: activities[index].clientName ?? '--',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: SizeSystem.size4,
                          ),
                          Text(
                            dateFormatter(activities[index].activityDate),
                            style: const TextStyle(
                              color: ColorSystem.secondary,
                              fontSize: 12,
                              fontFamily: kRubik,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: SizeSystem.size20,
                    ),
                    const Icon(
                      CupertinoIcons.chevron_forward,
                      color: ColorSystem.primary,
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: ColorSystem.secondary,
                  height: 20,
                );
              },
            );
        }
      },
    );
  }
}

class AbandonedCartList extends StatelessWidget {
  var listOfRecommendationImage = [
    MusicIconsSystem.bassoon,
    MusicIconsSystem.bassGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    MusicIconsSystem.bassGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: listOfRecommendationImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleAbandonedCartList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleAbandonedCartList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.greyBg,
          ),
          child: SvgPicture.asset(
            listOfRecommendationImage[index],
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class BrowsingtList extends StatelessWidget {
  BrowsingtList({Key? key}) : super(key: key);

  var listOfOrderImage = [
    LandingImages.guitarNew,
    MusicIconsSystem.doubleBass,
    MusicIconsSystem.electricGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        itemCount: listOfOrderImage.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(
                width: SizeSystem.size18,
              ),
              getSingleBrowsingList(context, index),
            ],
          );
        },
      ),
    );
  }

  Widget getSingleBrowsingList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.greyBg,
          ),
          child:
              SvgPicture.asset(listOfOrderImage[index], color: Colors.black87),
        ),
      ],
    );
  }
}
