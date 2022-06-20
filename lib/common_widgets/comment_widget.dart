import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class AddComment extends StatefulWidget {
  const AddComment({Key? key, this.previousComment}) : super(key: key);

  final String? previousComment;

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
            color: const Color(0xff8C80F8).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0), color: Colors.white),
            padding: const EdgeInsets.only(
                top: 0.0, left: 14, right: 14, bottom: 18),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.previousComment,
                    showCursor: true,
                    cursorColor: ColorSystem.primary,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: widget.previousComment == null
                          ? Row(
                              children: [
                                SvgPicture.asset(IconSystem.edit),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                const Text('Add Comment',
                                    style: TextStyle(
                                      color: Color(0xff9C9EB9),
                                      fontSize: SizeSystem.size12,
                                      fontFamily: kRubik,
                                      // fontWeight: FontWeight.w600
                                    )),
                              ],
                            )
                          : null,
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
                      onTap: () {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                      },
                      child: const Text(
                        'Post',
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
      ),
    );
  }
}
