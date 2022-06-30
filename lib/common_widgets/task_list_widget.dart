import 'dart:convert';
import 'dart:ui';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/store.dart';
import 'package:salesforce_spo/models/task.dart';
import 'package:url_launcher/url_launcher.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../models/agent.dart';
import '../services/networking/endpoints.dart';
import '../services/networking/networking_service.dart';
import '../services/networking/request_body.dart';
import '../services/storage/shared_preferences_service.dart';
import '../utils/constants.dart';

class TaskListWidget extends StatefulWidget {
  final String taskId;
  final String? subject;
  final String? taskType;
  final String? status;
  final String? activityDate;
  final String? phone;
  final String? email;
  final TaskModel task;
  final bool isOverdue;
  final VoidCallback onTap;
  final bool showingStoreTasks;

  const TaskListWidget({
    Key? key,
    required this.taskId,
    required this.task,
    required this.onTap,
    this.subject,
    this.taskType,
    this.status,
    this.activityDate,
    this.email,
    this.phone,
    this.isOverdue = false,
    this.showingStoreTasks = false,
  }) : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  late Future<void> futureAgents;
  late Future<void> futureStores;

  List<Agent> agents = [];
  List<Agent> searchedList = [];

  List<Store> stores = [];
  List<Store> searchedStoreList = [];

  String assigneeId = '';

  bool showingStores = false;

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

  Future<void> getFutureStores() async {
    var response = await HttpService().doGet(path: Endpoints.getStoreList());

    if (response.data != null) {
      for (var storeJson in response.data['StoreList']) {
        stores.add(Store.fromJson(storeJson));
      }
    }
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
    if (agentList[index].id != null) {
      assigneeId = agentList[index].id!;
    }

    if (assigneeId.isNotEmpty) {
      await updateTaskAssignee();
      Navigator.of(context).pop();
    }
  }

  void onStoreClicked(int index, List<Store> storeList) async {
    assigneeId = storeList[index].id;

    if (assigneeId.isNotEmpty) {
      await updateTaskAssignee();
      Navigator.of(context).pop();
    }
  }

  void onAgentSearch(String idOrName) {
    searchedList.clear();
    if (idOrName.trim().isEmpty) {
      return;
    }
    for (var agent in agents) {
      if (agent.name!.contains(idOrName) || agent.id!.contains(idOrName)) {
        searchedList.add(agent);
      }
    }
  }

  void onStoreSearch(String name) {
    searchedStoreList.clear();
    if (name.trim().isEmpty) {
      return;
    }
    for (var store in stores) {
      if (store.name!.contains(name)) {
        searchedStoreList.add(store);
      }
    }
  }

  @override
  initState() {
    super.initState();
    futureAgents = getFutureAgents();
    futureStores = getFutureStores();
  }

  String getSubtitleFromDate(String? activityDate) {
    if (widget.status == 'Completed') {
      return 'Completed';
    } else {
      if (activityDate == null) {
        return '';
      } else {
        var dateTime = DateTime.parse(activityDate);
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final yesterday = DateTime(now.year, now.month, now.day - 1);
        final tomorrow = DateTime(now.year, now.month, now.day + 1);
        final dateToCheck =
            DateTime(dateTime.year, dateTime.month, dateTime.day);
        if (dateToCheck == today) {
          return 'Today';
        } else if (dateToCheck == yesterday ||
            dateToCheck.millisecondsSinceEpoch <
                yesterday.millisecondsSinceEpoch) {
          return DateFormat('MMM dd, yyyy').format(dateTime);
        } else if (dateToCheck == tomorrow) {
          return 'Tomorrow';
        } else {
          return DateFormat('MMM dd, yyyy').format(dateTime);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: PaddingSystem.padding12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.subject}',
                    style: const TextStyle(
                      fontSize: SizeSystem.size16,
                      color: ColorSystem.primary,
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
                      ),
                      children: [
                        TextSpan(
                          text: widget.taskType != null ? '${widget.taskType} : ' : '',
                          style: const TextStyle(
                            fontSize: SizeSystem.size14,
                            color: ColorSystem.secondary,
                          ),
                        ),
                        TextSpan(
                          text: widget.isOverdue
                              ? 'Overdue'
                              : getSubtitleFromDate(widget.activityDate),
                          style: TextStyle(
                            fontSize: SizeSystem.size14,
                            color: widget.isOverdue
                                ? ColorSystem.complimentary
                                : getSubtitleFromDate(widget.activityDate)
                                        .contains('Completed')
                                    ? ColorSystem.additionalGreen
                                    : ColorSystem.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.showingStoreTasks ?
            InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () async {
                await showModalBottomSheet(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: StatefulBuilder(
                          builder: (BuildContext statefulBuilderContext,
                              void Function(void Function())
                              statefulBuilderSetState) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          maxLines: 1,
                                          cursorColor:
                                          ColorSystem.primary,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              if (showingStores) {
                                                onStoreSearch(value);
                                              } else {
                                                onAgentSearch(value);
                                              }
                                              statefulBuilderSetState(
                                                      () {});
                                            }
                                            if (value.isEmpty) {
                                              searchedList.clear();
                                              searchedStoreList.clear();
                                              statefulBuilderSetState(
                                                      () {});
                                            }
                                          },
                                          decoration:
                                          const InputDecoration(
                                            hintText: 'Search by ID',
                                            hintStyle: TextStyle(
                                              color:
                                              ColorSystem.secondary,
                                              fontSize: SizeSystem.size18,
                                            ),
                                            focusedBorder:
                                            UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                ColorSystem.primary,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: SizeSystem.size20,
                                      ),
                                      AnimatedToggleSwitch<bool>.dual(
                                        current: showingStores,
                                        first: false,
                                        second: true,
                                        dif: 1.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 3.0,
                                        height: 30,
                                        indicatorSize: const Size(
                                            28, double.infinity),
                                        indicatorColor: ColorSystem.white,
                                        innerColor: ColorSystem.primary,
                                        onChanged: (b) {
                                          showingStores = b;
                                          statefulBuilderSetState(() {});
                                        },
                                        textBuilder: (value) => value
                                            ? const Icon(
                                          Icons.storefront_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                            : const Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: FutureBuilder(
                                    future: Future.wait([
                                      futureAgents,
                                      futureStores,
                                    ]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                        case ConnectionState.active:
                                          return const Center(
                                            child:
                                            CircularProgressIndicator(
                                              color: ColorSystem.primary,
                                            ),
                                          );

                                        case ConnectionState.done:
                                          if (showingStores) {
                                            return searchedStoreList
                                                .isNotEmpty
                                                ? showStoresList(
                                                searchedStoreList)
                                                : showStoresList(stores);
                                          } else {
                                            return searchedList.isNotEmpty
                                                ? showAgentList(
                                                searchedList)
                                                : showAgentList(agents);
                                          }
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
                await updateTaskAssignee();
              },
              child: SvgPicture.asset(
                IconSystem.assignTask,
                height: 24,
                width: 24,
                color: ColorSystem.lavender,
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget showAgentList(List<Agent> agents) {
    return ListView.separated(
      itemCount: agents.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            onTaskAssigneeClicked(index, agents);
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  agents[index].name ?? '--',
                  style: const TextStyle(
                    color: ColorSystem.primary,
                    fontSize: SizeSystem.size18,
                    fontFamily: kRubik,
                  ),
                ),
                Text(
                  agents[index].employeeId ?? '--',
                  style: const TextStyle(
                    color: ColorSystem.secondary,
                    fontSize: SizeSystem.size18,
                    fontFamily: kRubik,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          height: 2,
          color: Colors.grey.withOpacity(0.3),
        );
      },
    );
  }

  Widget showStoresList(List<Store> stores) {
    return ListView.separated(
      itemCount: stores.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            onStoreClicked(index, stores);
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Text(
              stores[index].name ?? '--',
              style: const TextStyle(
                color: ColorSystem.primary,
                fontSize: SizeSystem.size18,
                fontFamily: kRubik,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          height: 2,
          color: Colors.grey.withOpacity(0.3),
        );
      },
    );
  }
}
