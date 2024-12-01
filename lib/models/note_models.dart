class Note {
  int? id;
  String? tittle;
  DateTime? date;
  String? priority;
  int? status;
  Note({this.tittle, this.date, this.priority, this.status});
  Note.withId({this.id, this.tittle, this.date, this.priority, this.status});
  Map<String, dynamic> toMap() {
    // ignore: prefer_collection_literals
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['tittle'] = tittle;
    map['date'] = date;
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note.withId(
      id: map["id"],
      tittle: map["tittle"],
      date: map["date"],
      status: map["status"],
    );
  }
}
