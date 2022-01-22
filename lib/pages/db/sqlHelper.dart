import 'package:mynote/pages/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'note.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT,note TEXT)',
        );
      },
      version: 1,
    );
  }

 static Future<void> insertNote(Note note) async {
    final db = await sqlHelper.db();

    await db.insert('note', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }



  static Future<List<Map<String, Object?>>> noteList() async {
    // Get a reference to the database.
    final db = await sqlHelper.db();

    // Query the table for all The Dogs.
    return db.rawQuery('SELECT * FROM note');
  }
 



  static Future<void>updateNote(Note note)async{
    final db = await sqlHelper.db();
    await db.update(
      'note',
      note.toMap(),
      where:'id = ?',
      whereArgs: [note.id]
    );
  }

  static Future<void>deleteNote(int id)async{
    final db = await sqlHelper.db();
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

}
