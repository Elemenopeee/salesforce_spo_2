import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

class SmartTriggerScreen extends StatefulWidget {
  const SmartTriggerScreen({Key? key}) : super(key: key);

  @override
  _SmartTriggerScreenState createState() => _SmartTriggerScreenState();
}

class _SmartTriggerScreenState extends State<SmartTriggerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircularPercentIndicator(
                        radius: 100 / 3,
                        lineWidth: 9.0,
                        percent: 0.98,
                        center: SvgPicture.asset(
                          IconSystem.icSparkle,
                        ),
                        backgroundColor: Colors.transparent,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              ColorSystem.secondaryBlue.withOpacity(0.2),
                              ColorSystem.secondaryBlue.withOpacity(0.2)
                            ]),
                        rotateLinearGradient: true,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        radius: 100 / 3,
                        lineWidth: 9.0,
                        percent: 0.52,
                        startAngle: 360,
                        backgroundColor: Colors.transparent,
                        linearGradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              ColorSystem.secondaryBlue,
                              ColorSystem.secondaryBlue
                            ]),
                        rotateLinearGradient: true,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Today",
                  style: TextStyle(
                    fontSize: SizeSystem.size14,
                    fontFamily: kRubik,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                CircularPercentIndicator(
                  radius: 250 / 3,
                  lineWidth: 15.0,
                  percent: 0.40,
                  backgroundColor: Colors.transparent,
                  center: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        SvgPicture.asset(
                          IconSystem.taskNote,
                          height: SizeSystem.size40,
                          width: SizeSystem.size20,
                        ),
                        const Text(
                          "85%",
                          style: TextStyle(
                            fontSize: SizeSystem.size24,
                            fontFamily: kRubik,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "3 / 10",
                          style: TextStyle(
                            fontSize: SizeSystem.size14,
                            fontFamily: kRubik,
                          ),
                        ),
                        const Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: SizeSystem.size14,
                            fontFamily: kRubik,
                          ),
                        ),
                      ],
                    ),
                  ),
                  linearGradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[ColorSystem.greyBg, ColorSystem.greyBg]),
                  rotateLinearGradient: true,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                CircularPercentIndicator(
                  radius: 250 / 3,
                  lineWidth: 15.0,
                  percent: 0.70,
                  startAngle: 220,
                  backgroundColor: Colors.transparent,
                  linearGradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        ColorSystem.lavender3,
                        ColorSystem.lavender3
                      ]),
                  rotateLinearGradient: true,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  IconSystem.icEmojiHappy,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "C.Sat",
                  style: TextStyle(
                    fontSize: SizeSystem.size14,
                    fontFamily: kRubik,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

// Center(
// child: CircularPercentIndicator(
// radius: 100.0,
// startAngle: 100,
// percent: 0.775 * yourPercentage,
// animation: true,
//
// backgroundColor: Colors.transparent,
// circularStrokeCap: CircularStrokeCap.round,
// progressColor: Colors.redAccent,
// center: const Text("50%"),
// ),
// ),
