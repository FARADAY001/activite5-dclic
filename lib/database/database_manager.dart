import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'redacteurs.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE redacteurs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT,
            prenom TEXT,
            email TEXT
          )
        ''');
      },
    );
  }

  Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await database;
    final result = await db.query('redacteurs');
    return result.map((e) => Redacteur.fromMap(e)).toList();
  }

  Future<void> insertRedacteur(Redacteur r) async {
    final db = await database;
    await db.insert('redacteurs', r.toMap());
  }

  Future<void> updateRedacteur(Redacteur r) async {
    final db = await database;
    await db.update(
      'redacteurs',
      r.toMap(),
      where: 'id = ?',
      whereArgs: [r.id],
    );
  }

  Future<void> deleteRedacteur(int id) async {
    final db = await database;
    await db.delete(
      'redacteurs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
