import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/TaskModel.dart';


class TaskController extends GetxController {
  static Database? _database;
  var tasks = <TaskModel>[].obs;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database!;
  }

  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'team_tasks_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title TEXT, "
                "description TEXT, "
                "imagemu TEXT"
                ")"
        );
      },
    );
  }

  Future<int> addTask(TaskModel task) async {
    var dbClient = await database;
    int result = await dbClient.insert('tasks', task.toMap());
    await loadTasks();
    return result;
  }

  Future<void> loadTasks() async {
    var dbClient = await database;
    List<Map<String, dynamic>> queryResult = await dbClient.query('tasks');
    tasks.assignAll(queryResult.map((data) => TaskModel.fromMap(data)).toList());
  }

  Future<void> deleteTask(int id) async {
    var dbClient = await database;
    await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
    await loadTasks();
  }
}