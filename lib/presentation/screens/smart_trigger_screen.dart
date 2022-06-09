import 'package:flutter/material.dart';

class SmartTriggerScreen extends StatefulWidget {
  const SmartTriggerScreen({Key? key}) : super(key: key);

  @override
  _SmartTriggerScreenState createState() => _SmartTriggerScreenState();
}

class _SmartTriggerScreenState extends State<SmartTriggerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        value: 100.0,
        color: Colors.red,
      )),
    ));
  }
}
