import 'package:my_simple_note/models/note_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;
  static final DatabaseService instance = DatabaseService._constructor();


  DatabaseService._constructor();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await getDatabase();
    return _database!;

  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'my_simple_note.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE note(id TEXT PRIMARY KEY, title TEXT, content TEXT)',
        );
      }
    );
    return database;
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database;
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteDataModel>> getNotes() async {
    final db = await database;
    final data = await db.query('note');
    List<NoteDataModel> tasks = data
        .map(
          (e) => NoteDataModel(
        id: e["id"] as String,
        title: e["title"] as String,
        content: e["content"] as String,
      ),
    )
        .toList();
    return tasks;
  }

  Future<void> delete(String table, String id) async {
    final db = await database;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
