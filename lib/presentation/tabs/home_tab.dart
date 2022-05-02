import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var listOfName = [
    "Sebastian",
    "Amanda",
    "You / Claire",
    "Sebastian",
    "Amanda",
    "You / Claire",
  ];
  var listOfViews = [
    "105 k",
    "73 k",
    "51 k",
    "105 k",
    "73 k",
    "51 k",
  ];

  @override
  Widget build(BuildContext context) {
    return getMainLayout;
  }

  get getMainLayout => SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          getProfileContainer,
          const SizedBox(
            height: 20,
          ),
          getMatrixMonth,
          const SizedBox(
            height: 10,
          ),
          getProgressContainer,
          const SizedBox(
            height: 30,
          ),
          getUserProfileContainer,
          const SizedBox(
            height: 20,
          ),
          getEmployeeList,
        ],
      ),
    ),
  );

  get getProfileContainer => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  IconSystem.user,
                  width: 30,
                  height: 30,
                  color: Color(0xFF888888),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "WED 16 MAR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 05),
              child: Text(
                "Hi, ${"John"}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Stack(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.pinkAccent),
            ),
            Positioned(
              top: 52,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  get getMatrixMonth => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Metrics of Month",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          Icons.more_horiz_outlined,
          color: Colors.grey.withOpacity(0.2),
          size: 40,
        ),
      ],
    ),
  );

  get getProgressContainer => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurpleAccent.withOpacity(0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Text(
                    "MY SALES",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                Center(
                  child: SvgPicture.asset(
                    IconSystem.menu,
                    width: 30,
                    height: 30,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(
                  height: 08,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "12% ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: "of store",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 08,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "29k This Month",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurpleAccent.withOpacity(0.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Text(
                    "MY COMMISSION",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 08,
                ),
                Center(
                  child: SvgPicture.asset(
                    IconSystem.notifications,
                    width: 30,
                    height: 30,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(
                  height: 08,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "1.4",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: "k",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 08,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Nice Job!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  get getUserProfileContainer => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.orange,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sebastian"),
            Row(
              children: [
                SvgPicture.asset(
                  IconSystem.notifications,
                  width: 30,
                  height: 30,
                  color: Color(0xFF888888),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Achievement * FEB HERO!",
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Icon(
          Icons.more_horiz_outlined,
          color: Colors.grey.withOpacity(0.2),
          size: 40,
        ),
      ],
    ),
  );

  get getEmployeeList => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "LEADERBOARD",
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Employee of the month!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: listOfName.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      getSingleEmployeeContainer(context, index),
                    ],
                  );
                }),
          )
        ],
      ),
    ),
  );

  Widget getSingleEmployeeContainer(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.orange),
              ),
              Text(
                listOfName[index],
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                listOfViews[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SvgPicture.asset(
                IconSystem.notifications,
                width: 30,
                height: 30,
                color: Color(0xFF888888),
              ),
            ],
          ),
        ),
      ),
    );
  }
}