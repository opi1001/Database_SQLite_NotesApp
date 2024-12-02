import 'dart:io';
import 'package:database_sqlite_notes_app/models/note_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteHelper {
  static final SqLiteHelper instance = SqLiteHelper._instance();
  static Database? db = null;
  SqLiteHelper._instance();

  String noteTable = 'note_table';
  String callId = 'id';
  String callTittle = 'tittle';
  String callData = 'data';
  String callPriority = 'priority';
  String callStatus = 'status';

  /*
          ! This is Our Note Table look Like;
          Id | Tittle | Date | Priority | Status
          0    "  "     "  "    "   "      "  "
          1    "  "     "  "    "   "      "  "
   */

  Future<Database?> get _db async {
    if (_db == null) {
      db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListDB = await openDatabase(path, version: 1, onCreate: createDb);
    return _initDb();
  }

  void createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $noteTable($callId INTEGER PRIMARY KEY AUTOINCREMENT, $callTittle TEXT,$callData TEXT,$callPriority TEXT,$callStatus TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await this._db;
    final List<Map<String, dynamic>> result = await db!.query(noteTable);
    return result;
  }

  Future<List<Note>> getNote() async {
    final List<Map<String, dynamic>> noteMapList = await getNoteMapList();
    final List<Note> noteList = [];

    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });
    noteList.sort((noteA, noteB) => noteA.date!.compareTo(noteB.date!));
    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await this._db;
    final int result = await db!.update(noteTable, note.toMap(),
        where: '$callId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database? db = await _db;
    final int result = await db!.update(noteTable, note.toMap(),
        where: '$callId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database? db = await _db;
    final int result =
        await db!.delete(noteTable, where: '$callId = ?', whereArgs: [id]);
    return result;
  }
}
