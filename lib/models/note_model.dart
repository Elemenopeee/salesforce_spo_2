class NoteModel {
  final String note;
  final String tag1;
  final String tag2;
  final String date;
  final bool expanded;
  NoteModel(
      {required this.note,
      required this.tag1,
      required this.tag2,
      required this.date,
      required this.expanded});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        note: json['note'],
        tag1: json['tag1'],
        tag2: json['tag2'],
        date: json['date'],
        expanded: false);
  }
}
