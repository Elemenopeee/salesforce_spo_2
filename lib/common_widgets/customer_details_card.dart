import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/constant_functions.dart';
import 'package:salesforce_spo/utils/enums/music_instrument_enum.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/constants.dart';

class CustomerDetailsCard extends StatefulWidget {
  final String? customerId;
  final String name;
  final String? email;
  final String? phone;
  final String? preferredInstrument;
  final String? lastTransactionDate;
  final double ltv;
  final double? averageProductValue;
  final String? customerLevel;

  const CustomerDetailsCard({
    Key? key,
    this.customerId,
    required this.name,
    this.email,
    this.phone,
    this.preferredInstrument,
    this.lastTransactionDate,
    this.ltv = 0,
    this.averageProductValue,
    this.customerLevel,
  }) : super(key: key);

  @override
  _CustomerDetailsCardState createState() => _CustomerDetailsCardState();
}

class _CustomerDetailsCardState extends State<CustomerDetailsCard> {
  String formattedNumber(double value) {
    var f = NumberFormat.compact(locale: "en_US");
    try{
      return f.format(value);
    }catch (e){
      return '0';
    }
  }

  String formatPhoneNumber(String number) {
    if (number.length == 10 && !number.contains(')')) {
      var formattedNumber = '(' +
          number.substring(0, 3) +
          ') ' +
          number.substring(3, 6) +
          '-' +
          number.substring(6, 10);
      return formattedNumber;
    } else {
      return number;
    }
  }

  String formatDate(String date) {
    return DateFormat('MM-dd-yyyy').format(DateTime.parse(date));
  }

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
        margin: const EdgeInsets.all(10),
        color: ColorSystem.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: PaddingSystem.padding10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: kRubik,
                        ),
                        children: [
                          TextSpan(
                            text: '${widget.name} •',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
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
                          WidgetSpan(
                            child: SvgPicture.asset(
                              IconSystem.badge,
                              height: SizeSystem.size16,
                              color: getCustomerLevelColor(
                                  getCustomerLevel(widget.ltv)),
                            ),
                          ),
                          const WidgetSpan(
                            child: SizedBox(
                              width: SizeSystem.size4,
                            ),
                          ),
                          TextSpan(
                            text: getCustomerLevel(widget.ltv),
                            style: TextStyle(
                              color: getCustomerLevelColor(
                                  getCustomerLevel(widget.ltv)),
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size12,
                            ),
                          ),
                          if (widget.lastTransactionDate != null)
                            TextSpan(
                              text:
                                  ' • L. Purchased : ${formatDate(widget.lastTransactionDate!)}',
                              style: const TextStyle(
                                fontSize: SizeSystem.size12,
                                color: ColorSystem.secondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (widget.email != null)
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
                    if (widget.phone != null)
                      const SizedBox(
                        height: SizeSystem.size5,
                      ),
                    if (widget.phone != null)
                      Text(
                        formatPhoneNumber(widget.phone!),
                        style: const TextStyle(
                          fontSize: SizeSystem.size12,
                          color: ColorSystem.primary,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: SizeSystem.size10,
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomerMicroDetails(
              label: 'LTV',
              value: '\$${formattedNumber(widget.ltv).toLowerCase()}',
            ),
            if (widget.averageProductValue != null)
              CustomerMicroDetails(
                label: 'AOV',
                value:
                    '\$${formattedNumber(widget.averageProductValue!).toLowerCase()}',
              ),
            if (widget.preferredInstrument != null)
              MusicInstrument.getInstrumentIcon(
                          MusicInstrument.getMusicInstrumentFromString(
                              widget.preferredInstrument!)) ==
                      '--'
                  ? CustomerMicroDetails(
                      label: widget.preferredInstrument!,
                      value: '--',
                    )
                  : CustomerMicroDetails(
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
              '\$${widget.value}',
              style: const TextStyle(
                color: ColorSystem.primary,
                fontFamily: kRubik,
              )
            ),
      ),
      const SizedBox(
        height: SizeSystem.size10,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.16,
        child: Center(
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: ColorSystem.secondary,
              fontSize: SizeSystem.size12,
              fontFamily: kRubik,
            ),
          ),
        ),
      )
    ]);
  }
}
