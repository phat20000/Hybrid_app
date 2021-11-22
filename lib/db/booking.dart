import 'package:appbooking/model/book.dart';
import 'package:appbooking/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookDatabase {
  static final BookDatabase instance = BookDatabase._init();
  static Database? _database;

  BookDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('book.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 4, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const stringType = 'TEXT';
    const intType = 'INTEGER';
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableNote (
      ${NoteFields.id} $idType,
      ${NoteFields.name} $stringType,
      ${NoteFields.dateTime} $stringType, 
      ${NoteFields.idBook} $intType
    )
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableBooking(
      ${BookFields.id} $idType,
      ${BookFields.status} $boolType,
      ${BookFields.name} $stringType,
      ${BookFields.address} $stringType,
      ${BookFields.city} $stringType,
      ${BookFields.district} $stringType,
      ${BookFields.ward} $stringType,
      ${BookFields.typeProperty} $stringType,
      ${BookFields.furniture} $stringType,
      ${BookFields.bedrooms} $stringType,
      ${BookFields.price} $stringType,
      ${BookFields.reporter} $stringType,
      ${BookFields.createdAt} $stringType

    )
    ''');
  }

  Future<Note> createNote(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNote, note.toJson());
    return note.copy(id: id);
  }

  Future<Booking> create(Booking booking) async {
    final db = await instance.database;

    final id = await db.insert(tableBooking, booking.toJson());
    return booking.copy(id: id);
  }

  Future readBooking(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableBooking,
        columns: BookFields.values,
        where: '${BookFields.id} = ? ',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Booking.fromJson(maps.first);
    } else {
      throw Exception("Id null");
    }
  }

  Future<List<Note>> readNotes(int id) async {
    final db = await instance.database;

    final sResult = await db.query(tableNote,
        columns: NoteFields.values,
        where: '${NoteFields.idBook} = ? ',
        whereArgs: [id]);

    return sResult.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Booking>> search(String name) async {
    final db = await instance.database;
    final result = await db.query(
      tableBooking,
      columns: BookFields.values,
      where: "${BookFields.name} LIKE ?",
      whereArgs: ["%$name%"],
    );
    return result.map((json) => Booking.fromJson(json)).toList();
  }

  Future<List<Booking>> readAll() async {
    final db = await instance.database;
    final orderBy = '${BookFields.id} ASC';
    final sResult = await db.query(tableBooking, orderBy: orderBy);
    if (sResult.length < 0) {
      return [];
    }
    return sResult.map((json) => Booking.fromJson(json)).toList();
  }

  Future<int> update(Booking booking) async {
    final db = await instance.database;
    return db.update(tableBooking, booking.toJson(),
        where: '${BookFields.id} = ? ', whereArgs: [booking.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db
        .delete(tableBooking, where: '${BookFields.id} = ? ', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
