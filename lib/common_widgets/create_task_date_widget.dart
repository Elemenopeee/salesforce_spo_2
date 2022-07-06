import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class CreateTaskDateWidget extends StatefulWidget {
  final String dueByDate;
  final Map<String, dynamic> dueDateMap;
  final String assigneeName;

  const CreateTaskDateWidget({
    Key? key,
    required this.dueByDate,
    required this.dueDateMap,
    required this.assigneeName,
  }) : super(key: key);

  @override
  State<CreateTaskDateWidget> createState() => _CreateTaskDateWidgetState();
}

class _CreateTaskDateWidgetState extends State<CreateTaskDateWidget> {
  String displayedDueDate = '';

  @override
  initState(){
    super.initState();
    displayedDueDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.dueByDate));
    widget.dueDateMap['dueDate'] = widget.dueByDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: ColorSystem.culturedGrey,
            borderRadius: BorderRadius.circular(14.0)),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                await showCupertinoModalPopup(
                  filter: ImageFilter.blur(
                    sigmaX: 4.0,
                    sigmaY: 4.0,
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(SizeSystem.size20),
                          topRight: Radius.circular(SizeSystem.size20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.parse(widget.dueByDate),
                              minimumDate: DateTime.parse(widget.dueByDate),
                              onDateTimeChanged: (val) {
                                setState(
                                  () {
                                    displayedDueDate =
                                        DateFormat('MMM dd, yyyy').format(val);
                                    widget.dueDateMap['dueDate'] =
                                        DateFormat('yyyy-MM-dd').format(val);
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SizeSystem.size40,
                              vertical: SizeSystem.size22,
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  ColorSystem.primary,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: SizeSystem.size16,
                                    ),
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: kRubik,
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
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Due by:",
                            style: TextStyle(
                                color: Color(0xff2D3142),
                                fontSize: SizeSystem.size14,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            displayedDueDate,
                            style: const TextStyle(
                                color: Color(0xff2D3142),
                                fontSize: SizeSystem.size18,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                    SvgPicture.asset(
                      IconSystem.calendar,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Assigned to:",
                    style: TextStyle(
                        color: ColorSystem.primary,
                        fontSize: SizeSystem.size12,
                        fontFamily: kRubik,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.assigneeName,
                        style: const TextStyle(
                          color: ColorSystem.primary,
                          fontSize: SizeSystem.size12,
                          fontFamily: kRubik,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
