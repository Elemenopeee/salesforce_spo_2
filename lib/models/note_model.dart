class NoteModel {
  final String note;
  final String tag1;
  final String tag2;
  final String date;
  NoteModel(
      {required this.note,
      required this.tag1,
      required this.tag2,
      required this.date});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        note: json['note'],
        tag1: json['tag1'],
        tag2: json['tag2'],
        date: json['date']);
  }
}
