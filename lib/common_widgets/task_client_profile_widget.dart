import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key, required this.name, required this.number, required this.email})
      : super(key: key);
  final String name;
  final String number;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.only(left: 8, top: 18.0, bottom: 18.0),
        decoration: BoxDecoration(
            color: Color(0xff8C80F8).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14.0)),
        child: Row(children: [
          CircleAvatar(radius: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Color(0xff2D3142),
                        fontSize: SizeSystem.size16,
                        fontFamily: kRubik,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.call_outlined),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                          child: Text(
                            number,
                            style: const TextStyle(
                                color: Color(0xff2D3142),
                                fontSize: SizeSystem.size14,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w300),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                          child: Text(
                            email,
                            style: const TextStyle(
                                color: Color(0xff2D3142),
                                fontSize: SizeSystem.size14,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w300),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}