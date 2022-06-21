import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/networking/request_body.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class AddComment extends StatefulWidget {
  const AddComment({
    Key? key,
    this.previousComment,
    required this.taskId,
  }) : super(key: key);

  final String? previousComment;
  final String taskId;

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController textEditingController = TextEditingController();

  String? previousComment;

  @override
  initState() {
    super.initState();
    previousComment = widget.previousComment;
  }

  Future<void> updateTaskComment() async {
    var response = await HttpService().doPost(
      path: Endpoints.postTaskDetails(widget.taskId),
      body: jsonEncode(
        RequestBody.getUpdateTaskBody(
            recordId: widget.taskId, comment: previousComment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
              color: const Color(0xff8C80F8).withOpacity(0.08),
              borderRadius: BorderRadius.circular(14.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (previousComment != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: SizeSystem.size20,
                    right: SizeSystem.size20,
                    bottom: SizeSystem.size16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Comment :',
                        style: TextStyle(
                          fontFamily: kRubik,
                          fontSize: SizeSystem.size12,
                          fontWeight: FontWeight.bold,
                          color: ColorSystem.primary,
                        ),
                      ),
                      const SizedBox(
                        height: SizeSystem.size4,
                      ),
                      Text(
                        previousComment!,
                        style: const TextStyle(
                          fontFamily: kRubik,
                          fontSize: SizeSystem.size14,
                          color: ColorSystem.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Colors.white),
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 14, right: 14, bottom: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textEditingController,
                          showCursor: true,
                          cursorColor: ColorSystem.primary,
                          cursorHeight: SizeSystem.size12,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add Comment',
                            hintStyle: TextStyle(
                              color: ColorSystem.secondary,
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          enabled: true,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();

                              if (textEditingController.text.isNotEmpty) {
                                setState(() {
                                  previousComment = textEditingController.text;
                                  textEditingController.clear();
                                });
                                await updateTaskComment();
                              }

                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: ColorSystem.lavender2,
                                fontSize: SizeSystem.size14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
