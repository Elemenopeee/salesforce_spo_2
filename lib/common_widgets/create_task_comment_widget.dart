import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class CreateTaskCommentWidget extends StatefulWidget {
  final Map<String, dynamic> commentBody;

  const CreateTaskCommentWidget({
    Key? key,
    required this.commentBody,
  }) : super(key: key);

  @override
  State<CreateTaskCommentWidget> createState() =>
      _CreateTaskCommentWidgetState();
}

class _CreateTaskCommentWidgetState extends State<CreateTaskCommentWidget> {
  final TextEditingController textEditingController = TextEditingController();

  String comment = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: SizeSystem.size16,
        ),
        decoration: BoxDecoration(
            color: ColorSystem.culturedGrey,
            borderRadius: BorderRadius.circular(14.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  if (comment.isNotEmpty)
                    const Text(
                      'Comment :',
                      style: TextStyle(
                        fontFamily: kRubik,
                        fontSize: SizeSystem.size12,
                        fontWeight: FontWeight.bold,
                        color: ColorSystem.primary,
                      ),
                    ),
                  if (comment.isNotEmpty)
                    const SizedBox(
                      height: SizeSystem.size4,
                    ),
                  if (comment.isNotEmpty)
                    Text(
                      comment,
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
                        onChanged: (value){
                          if(value.isNotEmpty){
                            widget.commentBody['comment'] = value;
                          }
                        },
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
                                comment = textEditingController.text;
                                textEditingController.clear();
                              });
                              widget.commentBody['comment'] = comment;
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
    );
  }
}
