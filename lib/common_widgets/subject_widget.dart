import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class SubjectWidget extends StatefulWidget {
  const SubjectWidget({Key? key}) : super(key: key);

  @override
  State<SubjectWidget> createState() => _SubjectWidgetState();
}

class _SubjectWidgetState extends State<SubjectWidget> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
            color: ColorSystem.culturedGrey,
            borderRadius: BorderRadius.circular(14.0)),
        child: Padding(
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
                      label: Text(
                        'Subject:',
                        style: TextStyle(
                          color: ColorSystem.primary,
                          fontSize: SizeSystem.size12,
                          fontFamily: kRubik,
                        ),
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
                      },
                      child: const Text(
                        'Edit',
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
