import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/enums/music_instrument_enum.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/constants.dart';

class CustomerDetailsCard extends StatefulWidget {
  final String? customerId;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? preferredInstrument;
  final String? lastTransactionDate;
  final double? ltv;
  final double? averageProductValue;
  final String? customerLevel;

  const CustomerDetailsCard({
    Key? key,
    this.customerId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.preferredInstrument,
    this.lastTransactionDate,
    this.ltv,
    this.averageProductValue,
    this.customerLevel,
  }) : super(key: key);

  @override
  _CustomerDetailsCardState createState() => _CustomerDetailsCardState();
}

class _CustomerDetailsCardState extends State<CustomerDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await launchUrlString(
              'salesforce1://sObject/${widget.customerId}/view');
        } catch (e) {
          print(e);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        color: ColorSystem.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: PaddingSystem.padding10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '${widget.firstName} ${widget.lastName} •',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeSystem.size16,
                            color: ColorSystem.primary,
                          ),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          width: SizeSystem.size5,
                        )),
                        const TextSpan(
                          text: 'GC',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeSystem.size14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        if (widget.customerLevel != null)
                          WidgetSpan(
                            child: SvgPicture.asset(
                              IconSystem.badge,
                              height: SizeSystem.size16,
                              color:
                                  getCustomerLevelColor(widget.customerLevel!),
                            ),
                          ),
                        if (widget.customerLevel != null)
                          const WidgetSpan(
                            child: SizedBox(
                              width: SizeSystem.size4,
                            ),
                          ),
                        if (widget.customerLevel != null)
                          TextSpan(
                            text: widget.customerLevel!,
                            style: TextStyle(
                              color:
                                  getCustomerLevelColor(widget.customerLevel!),
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size12,
                            ),
                          ),
                        if (widget.lastTransactionDate != null)
                          TextSpan(
                            text:
                                ' • Visited on : ${widget.lastTransactionDate!}',
                            style: const TextStyle(
                              fontSize: SizeSystem.size12,
                              color: ColorSystem.secondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size10,
                  ),
                  if (widget.email != null)
                    Text(
                      widget.email!,
                      style: const TextStyle(
                        fontSize: SizeSystem.size12,
                        color: ColorSystem.primary,
                      ),
                    ),
                  const SizedBox(
                    height: SizeSystem.size5,
                  ),
                  if (widget.phone != null)
                    Text(
                      widget.phone!,
                      style: const TextStyle(
                        fontSize: SizeSystem.size12,
                        color: ColorSystem.primary,
                      ),
                    ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: SizeSystem.size20,
          ),
          Row(children: [
            if (widget.ltv != null)
              CustomerMicroDetails(label: 'LTV', value: widget.ltv!.toString()),
            if (widget.averageProductValue != null)
              CustomerMicroDetails(
                  label: 'AOV', value: widget.averageProductValue!.toString()),
            if (widget.preferredInstrument != null)
              CustomerMicroDetails(
                label: widget.preferredInstrument!,
                value: '',
                icon: SvgPicture.asset(MusicInstrument.getInstrumentIcon(
                    MusicInstrument.getMusicInstrumentFromString(
                        widget.preferredInstrument!))),
              ),
          ])
        ]),
      ),
    );
  }
}

class CustomerMicroDetails extends StatefulWidget {
  const CustomerMicroDetails(
      {Key? key, required this.value, required this.label, this.icon})
      : super(key: key);
  final String value;
  final String label;
  final Widget? icon;

  @override
  _CustomerMicroDetailsState createState() => _CustomerMicroDetailsState();
}

class _CustomerMicroDetailsState extends State<CustomerMicroDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: PaddingSystem.padding5),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.15,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PaddingSystem.padding10),
            color: ColorSystem.secondary.withOpacity(OpacitySystem.opacity01)),
        child: widget.icon ??
            Text(
              widget.value,
              style: const TextStyle(
                color: ColorSystem.primary,
                fontFamily: kRubik,
              ),
            ),
      ),
      const SizedBox(
        height: SizeSystem.size10,
      ),
      Text(
        widget.label,
        style: const TextStyle(
          color: ColorSystem.secondary,
          fontSize: SizeSystem.size12,
          fontFamily: kRubik,
        ),
      )
    ]);
  }
}

Color getCustomerLevelColor(String level) {
  switch (level) {
    case 'LOW':
      return ColorSystem.additionalYellow;
    case 'MEDIUM':
      return ColorSystem.lavender;
    case 'HIGH':
      return ColorSystem.complimentary;
    default:
      return ColorSystem.complimentary;
  }
}
