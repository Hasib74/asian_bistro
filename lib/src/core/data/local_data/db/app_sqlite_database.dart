import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the directory path for storing the database
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'favorite.db');

    // Open/create the database at a given path
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE Favorite (
        id INTEGER PRIMARY KEY,
        name TEXT,
        image TEXT,
        price TEXT,
        description TEXT,
        discount TEXT,
        rating TEXT,
        productType TEXT
      )
    ''');
  }
}
