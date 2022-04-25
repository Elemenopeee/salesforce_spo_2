import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class CustomerDetailsCard extends StatefulWidget {
  const CustomerDetailsCard({Key? key}) : super(key: key);

  @override
  _CustomerDetailsCardState createState() => _CustomerDetailsCardState();
}

class _CustomerDetailsCardState extends State<CustomerDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
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
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Jessica Mendez •',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size16,
                              color: ColorSystem.white)),
                      WidgetSpan(
                          child: SizedBox(
                        width: SizeSystem.size5,
                      )),
                      TextSpan(
                          text: 'GC',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size14,
                              color: Colors.grey))
                    ])),
                const SizedBox(
                  height: SizeSystem.size5,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.run_circle,
                        size: SizeSystem.size16,
                        color: ColorSystem.complimentary,
                      )),
                      WidgetSpan(
                          child: SizedBox(
                        width: SizeSystem.size4,
                      )),
                      TextSpan(
                          text: 'Premius',
                          style: TextStyle(
                              color: ColorSystem.complimentary,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size12)),
                      TextSpan(
                          text: ' • Visited on : 12-Mar-2022',
                          style: TextStyle(
                              fontSize: SizeSystem.size12,
                              color: ColorSystem.secondary)),
                    ])),
                const SizedBox(
                  height: SizeSystem.size10,
                ),
                const Text('example@apptware.com',
                    style: TextStyle(
                        fontSize: SizeSystem.size12,
                        color: ColorSystem.secondary)),
                const SizedBox(
                  height: SizeSystem.size5,
                ),
                const Text('+917057110312',
                    style: TextStyle(
                        fontSize: SizeSystem.size12,
                        color: ColorSystem.secondary)),
              ],
            )
          ],
        ),
        const SizedBox(
          height: SizeSystem.size20,
        ),
        Row(children: const [
          CustomerMicroDetails(label: 'LTV', value: '20k+'),
          CustomerMicroDetails(label: 'Level', value: 'Bas'),
          CustomerMicroDetails(
            label: 'Guitarist',
            value: '',
            icon: Icon(Icons.run_circle),
          ),
        ])
      ]),
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
        child: widget.icon ?? Text(widget.value),
      ),
      const SizedBox(
        height: SizeSystem.size10,
      ),
      Text(
        widget.label,
        style: const TextStyle(color: ColorSystem.secondary),
      )
    ]);
  }
}
