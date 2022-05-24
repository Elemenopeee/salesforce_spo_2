import 'package:flutter/material.dart';
import 'package:salesforce_spo/models/note_model.dart';

import '../../../common_widgets/note.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../utils/set_bg_color.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NoteModel> list = [
      NoteModel(
          note: 'Anything thats blue grabs her Interest',
          tag1: 'Engaging',
          tag2: 'Intresed in Accessories',
          date: '20-Mar-2022',
          expanded: false),
      NoteModel(
          note: 'She hates Hip - Hop',
          tag1: 'Guitar',
          tag2: 'Follow on Service',
          date: '22-Mar-2022',
          expanded: false),
      NoteModel(
          note: 'Anything thats blue grabs her Interest',
          tag1: 'Engaging',
          tag2: 'Intresed in Accessories',
          date: '23-Mar-2022',
          expanded: false),
      NoteModel(
          note: 'Anything thats blue grabs her Interest',
          tag1: 'Engaging',
          tag2: 'Intresed in Accessories',
          date: '23-Mar-2022',
          expanded: false),
      NoteModel(
        note: 'Anything thats blue grabs her Interest',
        tag1: 'Engaging',
        tag2: 'Intresed in Accessories',
        date: '23-Mar-2022',
        expanded: false,
      ),
      NoteModel(
        note: 'Anything thats blue grabs her Interest',
        tag1: 'Engaging',
        tag2: 'Intresed in Accessories',
        date: '23-Mar-2022',
        expanded: false,
      ),
      NoteModel(
        note: 'Anything thats blue grabs her Interest',
        tag1: 'Engaging',
        tag2: 'Intresed in Accessories',
        date: '23-Mar-2022',
        expanded: false,
      ),
      NoteModel(
        note: 'Anything thats blue grabs her Interest',
        tag1: 'Engaging',
        tag2: 'Intresed in Accessories',
        date: '23-Mar-2022',
        expanded: false,
      ),
    ];
    return Container(
        margin: const EdgeInsets.only(top: PaddingSystem.padding20),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return NoteWidget(
                note: list[index].note,
                tag1: list[index].tag1,
                tag2: list[index].tag2,
                date: list[index].date,
                bgColor: setBackgroundColor(index: index),
                pinned: list[index].expanded,
              );
            }));
  }
}
