import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/comment_widget.dart';
import 'package:salesforce_spo/common_widgets/product_list_card_widget.dart';
import 'package:salesforce_spo/common_widgets/task_client_profile_widget.dart';
import 'package:salesforce_spo/common_widgets/task_details_date_widget.dart';
import 'package:salesforce_spo/common_widgets/tgc_app_bar.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.scaffoldBackgroundColor,
      appBar: TGCAppBar(
        label: 'CALL ALERT',
        leadingWidget: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              IconSystem.leftArrow,
              color: ColorSystem.primary,
              height: SizeSystem.size12,
              width: SizeSystem.size24,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const [
          ProfileWidget(name: 'Rajas', number: '1234567890', email: 'email'),
          SizedBox(
            height: 20,
          ),
          ProductListCard(items: [], Id: 'id', Date: 'date'),
          SizedBox(
            height: 20,
          ),
          AddComment(
            assigned_to_name: 'Rajas',
            modified_by_name: 'Rajas',
            due_by_date: 'Todays date',
            modified_date: 'Yesterdays date',
          ),
          SizedBox(
            height: 20,
          ),
          TaskDetailsDateWidget(
            assigned_to_name: 'Rajas',
            modified_by_name: 'Rajas',
            due_by_date: 'Today',
            modified_date: 'Yesterday',
          )
        ],
      ),
    );
  }
}
