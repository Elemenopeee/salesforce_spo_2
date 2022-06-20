import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeSystem.size16,
          vertical: SizeSystem.size20,
        ),
        decoration: BoxDecoration(
            color: ColorSystem.lavender3.withOpacity(0.08),
            borderRadius: BorderRadius.circular(SizeSystem.size12)),
        child: Row(
          children: [
            CircleAvatar(
              radius: SizeSystem.size32,
              backgroundColor: ColorSystem.lavender3.withOpacity(0.5),
              child: SvgPicture.asset(
                IconSystem.userPlaceholder,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: SizeSystem.size16,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: SizeSystem.size10),
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
                    const SizedBox(
                      height: SizeSystem.size4,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconSystem.phone,
                          width: SizeSystem.size20,
                          color: ColorSystem.secondary,
                        ),
                        const SizedBox(
                          width: SizeSystem.size4,
                        ),
                        Flexible(
                            child: Text(
                          number,
                          style: const TextStyle(
                              color: ColorSystem.primary,
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.w300),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: SizeSystem.size4,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconSystem.mail,
                          width: SizeSystem.size20,
                          color: ColorSystem.secondary,
                        ),
                        const SizedBox(
                          width: SizeSystem.size4,
                        ),
                        Flexible(
                          child: Text(
                            email,
                            style: const TextStyle(
                                color: Color(0xff2D3142),
                                fontSize: SizeSystem.size14,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
