# sekyulait_aplikesyon

Mirza Zaki Rafii | 5025221018
Pemrograman Perangkat Bergerak B

Penugasan kali ini menggunakan kembali aplikasi yang dibuat dari penugasan sebelumnya, yaitu To-Do App. Pada penugasannya saya telah membuat database lokal menggunakan shared preference. Untuk penugasan kali ini akan diubah ke SQFLITE.

Tahap Pengerjaan :

- Install dependency SQFLITE dan Path

![image](https://github.com/user-attachments/assets/22fa9f73-eabf-4ba4-8262-0ebb5b1d0868)

- Buat file database_helper.dart untuk memanage sqflite nya

```
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            isCompleted INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}

```
  
- Update referensi shared preference dengan database_helper, termasuk TaskModel

Before:

![image](https://github.com/user-attachments/assets/06bde279-460a-49e4-b052-004778ae5915)

Setelah before:

![image](https://github.com/user-attachments/assets/45453cc5-0e73-4248-8462-4075cbb9b929)

- Testing

![image](https://github.com/user-attachments/assets/2196baca-43cc-40ae-8c19-037f5b50d148)

