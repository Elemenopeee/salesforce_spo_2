import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../models/agent.dart';

class AgentPopup extends StatelessWidget {
  final Agent agent;

  const AgentPopup({
    Key? key,
    required this.agent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 10,
        sigmaX: 10
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(
            vertical: SizeSystem.size16,
            horizontal: SizeSystem.size16,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeSystem.size16)),
          child: Row(
            children: [
              CircleAvatar(
                radius: SizeSystem.size30,
                backgroundColor: ColorSystem.lavender3.withOpacity(0.5),
                child: SvgPicture.asset(
                  IconSystem.userPlaceholder,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: SizeSystem.size10,
                    ),
                    Text(
                      agent.name ?? '--',
                      style: const TextStyle(
                        fontFamily: kRubik,
                        color: ColorSystem.primary,
                        fontSize: SizeSystem.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: SizeSystem.size10,
                    ),
                    Text(
                      agent.storeName ?? '--',
                      style: const TextStyle(
                        fontFamily: kRubik,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff2D3142),
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                    const SizedBox(
                      height: SizeSystem.size10,
                    ),
                    Text(
                      agent.profileName ?? '--',
                      style: const TextStyle(
                        fontFamily: kRubik,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff2D3142),
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                    const SizedBox(
                      height: SizeSystem.size10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconSystem.phone,
                          height: SizeSystem.size20,
                          width: SizeSystem.size20,
                        ),
                        const SizedBox(
                          width: SizeSystem.size6,
                        ),
                        Text(
                          agent.phone ?? '--',
                          style: const TextStyle(
                            fontFamily: kRubik,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff2D3142),
                            fontSize: SizeSystem.size12,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: SizeSystem.size10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconSystem.mail,
                          height: SizeSystem.size16,
                          width: SizeSystem.size16,
                        ),
                        const SizedBox(
                          width: SizeSystem.size6,
                        ),
                        const SizedBox(width: SizeSystem.size6),
                        Text(
                          agent.email ?? '--',
                          style: const TextStyle(
                            fontFamily: kRubik,
                            color: Color(0xff2D3142),
                            fontWeight: FontWeight.normal,
                            fontSize: SizeSystem.size12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
