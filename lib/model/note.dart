final String tableNote  = 'notes';
class NoteFields {
  static final List<String> values = [
    id,name,dateTime
  ];
  static const String id = '_id';
  static const String dateTime = 'dateTime';
  static const String name = 'name';
  static const String idBook = 'idBook';
}
class Note {
  final int? id;
  final String name;
  final String dateTime;
  final int? idBook;
  const Note({
    this.id,
    required this.name,
    required this.dateTime,
    this.idBook
  });

  Map<String,Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.name: name,
    NoteFields.dateTime: dateTime,
    NoteFields.idBook: idBook
  };

  Note copy({
    int? id,
    String? name,
    String? dateTime,
    int? idBook
  }) => Note(
          id: id ?? this.id,
          name: name ?? this.name,
          dateTime: dateTime ?? this.dateTime,
          idBook: idBook ?? this.idBook
        );

  static Note fromJson(Map<String, Object?> json) => 
    Note(
      id: json[NoteFields.id] as int?,
      name: json[NoteFields.name]  as String,
      dateTime: json[NoteFields.dateTime] as String,
      idBook: json[NoteFields.idBook] as int?
    );
}