import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/models/note.dart';
import 'package:salesforce_spo/models/note_model.dart';

import '../../../common_widgets/note_widget.dart';
import '../../../design_system/design_system.dart';
import '../../../design_system/primitives/icon_system.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../services/networking/endpoints.dart';
import '../../../services/networking/networking_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/set_bg_color.dart';

class NotesList extends StatefulWidget {
  final String customerID;

  const NotesList({Key? key, required this.customerID}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<NoteModel> noteList = [];

  // List<Note> noteIds = [];

  List<String> noteIds = [];

  bool isLoading = true;

  late Future<void> _futureNotes;

  int offset = 0;

  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  String formattedDate(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('MM-dd-yyyy').format(dateTime);
  }

  @override
  void initState() {
    _futureNotes = getNotesList(offset);
    super.initState();
  }

  Future<void> getNotesList(int offset) async {
    var response = await HttpService()
        .doGet(path: Endpoints.getClientNotesById(widget.customerID));

    try {
      for (var record in response.data['records']) {
        noteIds.add(record['ContentDocumentId']);
      }
    } catch (e) {
      print(e);
    }

    var responseNotes =
        await HttpService().doGet(path: Endpoints.getClientNotes(noteIds));

    try{
      for (var record in responseNotes.data['records'] ){
        noteList.add(NoteModel.fromJson(record));
      }
    } catch (e) {
      print(e);
    }
    isLoadingData = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureNotes,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              noteList.isEmpty) {
            return const Center(
              child: Center(
                  child: CircularProgressIndicator(
                color: ColorSystem.primary,
              )),
            );
          } else {
            if (noteList.isEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: SizeSystem.size50,
                  ),
                  SvgPicture.asset(IconSystem.noDataFound),
                  const SizedBox(
                    height: SizeSystem.size24,
                  ),
                  const Text(
                    'NO DATA FOUND!',
                    style: TextStyle(
                      color: ColorSystem.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: kRubik,
                      fontSize: SizeSystem.size20,
                    ),
                  )
                ],
              );
            }

            return Container(
                margin: const EdgeInsets.only(top: PaddingSystem.padding20),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: noteList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var noteItem = noteList[index];
                      return NoteWidget(
                        name: noteItem.lastModifiedBy?.name ?? "--",
                        note: noteItem.title ?? "--",
                        date: noteItem.createdDate == null
                            ? '--'
                            : formattedDate(noteItem.createdDate!),
                        bgColor: setBackgroundColor(index: index),
                        pinned: true,
                        description: noteItem.textPreview,
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
