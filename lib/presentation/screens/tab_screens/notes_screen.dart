import 'package:flutter/material.dart';
import 'package:salesforce_spo/models/note_model.dart';

import '../../../common_widgets/note.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../services/networking/endpoints.dart';
import '../../../services/networking/networking_service.dart';
import '../../../utils/set_bg_color.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<NoteModel> noteList = [];

  bool isLoading = true;

  late Future<void> _futureNotes;

  int offset = 0;

  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getNotesList(offset);
    _futureNotes = getNotesList(offset);
    super.initState();
  }

  Future<void> getNotesList(int offset) async {
    var linkedEntityId = ('0014M00001nv3BwQAI');
    var response = await HttpService()
        .doGet(path: Endpoints.getClientNotesById(linkedEntityId));
    isLoadingData = false;
    try {
      for (var notes in response.data['records']) {
        noteList.add(NoteModel.fromJson(notes));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureNotes,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              noteList.isEmpty) {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return Container(
                margin: const EdgeInsets.only(top: PaddingSystem.padding20),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      // return Container();
                      return NoteWidget(
                        note: noteList[index].title ?? "--",
                        tag1: noteList[index].textPreview ?? "--",
                        tag2: noteList[index].fileType ?? "--",
                        date: "",
                        bgColor: setBackgroundColor(index: index),
                        pinned: true,
                      );
                    }));
          }
        });
  }

  void scrollListener() {
    var maxExtent = scrollController.position.maxScrollExtent;
    var loadingPosition = maxExtent - (maxExtent * 0.4);
    if (scrollController.position.extentAfter < loadingPosition &&
        !isLoadingData) {
      offset = offset + 20;
      setState(() {
        isLoadingData = true;
        _futureNotes = getNotesList(offset);
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}
