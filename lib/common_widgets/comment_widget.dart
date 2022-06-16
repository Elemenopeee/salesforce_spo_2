import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class AddComment extends StatelessWidget {
  const AddComment(
      {Key? key,
        required this.assigned_to_name,
        required this.modified_by_name,
        required this.due_by_date,
        required this.modified_date,
        this.commentList = const []})
      : super(key: key);

  final String assigned_to_name;
  final String modified_by_name;
  final String due_by_date;
  final String modified_date;
  final List<AddCommentModel> commentList;
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
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white),
              padding: const EdgeInsets.only(
                  top: 0.0, left: 14, right: 14, bottom: 18),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.edit_note_rounded,
                  //       color: Color(0xff9C9EB9),
                  //       size: 26,
                  //     ),
                  //     SizedBox(
                  //       width: 5.0,
                  //     ),
                  //     Text('Add Comment',
                  //         style: TextStyle(
                  //           color: Color(0xff9C9EB9),
                  //           fontSize: SizeSystem.size12,
                  //           fontFamily: kRubik,
                  //           // fontWeight: FontWeight.w600
                  //         )),
                  //   ],
                  // ),
                  TextField(
                    showCursor: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Row(
                        children: [
                          Icon(
                            Icons.edit_note_rounded,
                            color: Color(0xff9C9EB9),
                            size: 26,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Add Comment',
                              style: TextStyle(
                                color: Color(0xff9C9EB9),
                                fontSize: SizeSystem.size12,
                                fontFamily: kRubik,
                                // fontWeight: FontWeight.w600
                              )),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    enabled: true,
                  ),
                ],
              ),
            ),
          ),
          commentList.isEmpty
              ? Container()
              : ListView.separated(
            itemCount: commentList.length,
            shrinkWrap: true,
            itemBuilder: (conext, index) =>
                CommentCard(commentList: commentList, item_no: index),
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Divider(
                  height: 1.0,
                  color: Color(0xff9C9EB9),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }


}

class CommentCard extends StatelessWidget {
  const CommentCard(
      {Key? key, required this.commentList, required this.item_no})
      : super(key: key);
  final int item_no;
  final List<AddCommentModel>? commentList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                commentList![item_no].name,
                style: TextStyle(
                    color: Color(0xff2D3142),
                    fontSize: SizeSystem.size12,
                    fontFamily: kRubik,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                commentList![item_no].date,
                style: TextStyle(
                    color: Color(0xff9C9EB9),
                    fontSize: SizeSystem.size12,
                    fontFamily: kRubik,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(commentList![item_no].comment_disc,
              style: TextStyle(
                  color: Color(0xff2D3142),
                  fontSize: SizeSystem.size14,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.normal))
        ],
      ),
    );
  }
}



class AddCommentModel {
  final String name;
  final String date;
  final String comment_disc;

  AddCommentModel(
      {required this.name, required this.date, required this.comment_disc});
}