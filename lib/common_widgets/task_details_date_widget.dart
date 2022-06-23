import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/models/agent.dart';
import 'package:salesforce_spo/models/task.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../design_system/design_system.dart';
import '../services/networking/request_body.dart';
import '../services/storage/shared_preferences_service.dart';
import '../utils/constants.dart';

class TaskDetailsDateWidget extends StatefulWidget {
  const TaskDetailsDateWidget(
      {Key? key,
      required this.task,
      required this.assigned_to_name,
      required this.modified_by_name,
      required this.due_by_date,
      required this.modified_date})
      : super(key: key);

  final TaskModel task;
  final String assigned_to_name;
  final String modified_by_name;
  final String due_by_date;
  final String modified_date;

  @override
  State<TaskDetailsDateWidget> createState() => _TaskDetailsDateWidgetState();
}

class _TaskDetailsDateWidgetState extends State<TaskDetailsDateWidget> {
  String dueDate = '';
  String lastModifiedDate = '';
  String assigneeName = '';
  String assigneeId = '';

  late DateTime selectedDate;

  late Future<void> futureAgents;

  List<Agent> agents = [];
  List<Agent> searchedList = [];

  Future<void> getFutureAgents() async {
    var storeId = await SharedPreferenceService().getValue('store_id');

    if (storeId != null) {
      var response =
          await HttpService().doGet(path: Endpoints.getStoreAgents(storeId));
      if (response.data != null) {
        for (var agentJson in response.data['AgentList']) {
          agents.add(Agent.fromJson(agentJson));
        }
      }
    }
  }

  Future<void> updateTaskDate() async {
    var response = await HttpService().doPost(
        path: Endpoints.postTaskDetails(widget.task.id!),
        body: jsonEncode(
          RequestBody.getUpdateTaskBody(
            recordId: widget.task.id!,
            dueDate: DateFormat('yyyy-MM-dd').format(selectedDate),
          ),
        ));
  }

  Future<void> updateTaskAssignee() async {
    var response = await HttpService().doPost(
      path: Endpoints.postTaskDetails(widget.task.id!),
      body: jsonEncode(
        RequestBody.getUpdateTaskBody(
          recordId: widget.task.id!,
          assignee: assigneeId,
        ),
      ),
    );
  }

  void onTaskAssigneeClicked(int index, List<Agent> agentList) async {
    assigneeName = agentList[index].name ?? '--';
    if (agentList[index].id != null) {
      assigneeId = agentList[index].id!;
    }

    if (assigneeId.isNotEmpty) {
      await updateTaskAssignee();
      Navigator.of(context).pop();
    }
  }

  void onSearch(String idOrName){
    searchedList.clear();
    if(idOrName.trim().isEmpty){
      return;
    }
    for (var agent in agents) {
      if(agent.name!.contains(idOrName) || agent.id!.contains(idOrName)){
        searchedList.add(agent);
      }
    }
  }

  @override
  initState() {
    super.initState();
    futureAgents = getFutureAgents();
    assigneeName = widget.assigned_to_name;
    dueDate =
        DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.due_by_date));
    if (lastModifiedDate != '--') {
      lastModifiedDate = DateFormat('MMM dd, yyyy')
          .format(DateTime.parse(widget.modified_date.substring(0, 10)));
    }
    selectedDate = DateTime.parse(widget.due_by_date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: const Color(0xff8C80F8).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14.0)),
        child: Column(
          children: [
            InkWell(
              onTap: widget.task.status != 'Completed'
                  ? () async {
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
                                    initialDateTime: DateTime.now(),
                                    minimumDate:
                                        DateTime.parse(widget.due_by_date),
                                    onDateTimeChanged: (val) {
                                      setState(
                                        () {
                                          dueDate = DateFormat('MMM dd, yyyy')
                                              .format(val);
                                          selectedDate = val;
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        ColorSystem.primary,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      await updateTaskDate();
                    }
                  : () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white),
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
                            dueDate,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Assigned to:",
                        style: TextStyle(
                            color: Color(0xff2D3142),
                            fontSize: SizeSystem.size12,
                            fontFamily: kRubik,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Modified by:",
                        style: TextStyle(
                            color: Color(0xff2D3142),
                            fontSize: SizeSystem.size12,
                            fontFamily: kRubik,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: widget.task.status != 'Completed'
                              ? () async {
                                  await showModalBottomSheet(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: StatefulBuilder(
                                            builder: (BuildContext
                                                    statefulBuilderContext,
                                                void Function(void Function())
                                                    statefulBuilderSetState) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: TextFormField(
                                                      maxLines: 1,
                                                      onChanged: (value) {
                                                        if(value.isNotEmpty){
                                                          onSearch(value);
                                                          statefulBuilderSetState((){});
                                                        }
                                                        if(value.isEmpty){
                                                          searchedList.clear();
                                                          statefulBuilderSetState((){});
                                                        }
                                                      },
                                                      cursorColor: ColorSystem.primary,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Search by ID',
                                                        hintStyle: TextStyle(
                                                          color: ColorSystem
                                                              .secondary,
                                                          fontSize:
                                                              SizeSystem.size18,
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: ColorSystem
                                                                .primary,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: FutureBuilder(
                                                      future: futureAgents,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                          case ConnectionState
                                                              .waiting:
                                                          case ConnectionState
                                                              .active:
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    ColorSystem
                                                                        .primary,
                                                              ),
                                                            );

                                                          case ConnectionState
                                                              .done:
                                                            return
                                                            searchedList.isNotEmpty ?
                                                            ListView
                                                                .separated(
                                                              itemCount:
                                                              searchedList.length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                              context,
                                                                  int index) {
                                                                return GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    onTaskAssigneeClicked(
                                                                        index, searchedList);
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    color: Colors
                                                                        .white,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        26,
                                                                        vertical:
                                                                        16),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          searchedList[index].name ??
                                                                              '--',
                                                                          style:
                                                                          const TextStyle(
                                                                            color:
                                                                            ColorSystem.primary,
                                                                            fontSize:
                                                                            SizeSystem.size18,
                                                                            fontFamily:
                                                                            kRubik,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          searchedList[index].employeeId ??
                                                                              '--',
                                                                          style:
                                                                          const TextStyle(
                                                                            color:
                                                                            ColorSystem.secondary,
                                                                            fontSize:
                                                                            SizeSystem.size18,
                                                                            fontFamily:
                                                                            kRubik,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (BuildContext
                                                              context,
                                                                  int index) {
                                                                return Container(
                                                                  width: double
                                                                      .maxFinite,
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                    horizontal:
                                                                    16,
                                                                  ),
                                                                  height: 2,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                      0.3),
                                                                );
                                                              },
                                                            ) :
                                                              ListView
                                                                .separated(
                                                              itemCount:
                                                                  agents.length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    onTaskAssigneeClicked(
                                                                        index, agents);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            26,
                                                                        vertical:
                                                                            16),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          agents[index].name ??
                                                                              '--',
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ColorSystem.primary,
                                                                            fontSize:
                                                                                SizeSystem.size18,
                                                                            fontFamily:
                                                                                kRubik,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          agents[index].employeeId ??
                                                                              '--',
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ColorSystem.secondary,
                                                                            fontSize:
                                                                                SizeSystem.size18,
                                                                            fontFamily:
                                                                                kRubik,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Container(
                                                                  width: double
                                                                      .maxFinite,
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                  ),
                                                                  height: 2,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                );
                                                              },
                                                            );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {});
                                }
                              : null,
                          child: Text(
                            assigneeName,
                            style: const TextStyle(
                              color: Color(0xff53A5FF),
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: widget.modified_by_name + " ",
                          style: const TextStyle(
                              color: Color(0xff53A5FF),
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.w600),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "| " + lastModifiedDate,
                              style: const TextStyle(
                                  color: Color(0xff2D3142),
                                  fontSize: SizeSystem.size12,
                                  fontFamily: kRubik,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
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
