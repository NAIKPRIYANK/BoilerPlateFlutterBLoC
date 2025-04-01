
import 'package:flutterboilerplateblocpattern/models/user_info.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('book_heaven.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        ageGroup TEXT NOT NULL,
        gender TEXT NOT NULL,
        interests TEXT
      )
    ''');

    //  Create BagBooks Table (Relation with Users)
    await db.execute('''
    CREATE TABLE bag_books (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      book_name TEXT NOT NULL,
      book_price REAL NOT NULL,
      quantity INTEGER NOT NULL,
      description TEXT NOT NULL,
      imagePath TEXT NOT NULL,
      book_id INTEGER NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    )
  ''');
  }

  ///  Check if email already exists
  Future<bool> emailExists(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  ///  Register a new user (Ensuring non-null values)
  Future<int> registerUser(UserModel user) async {
    final db = await instance.database;

    if (user.username.isEmpty ||
        user.email.isEmpty ||
        user.password.isEmpty ||
        user.ageGroup.isEmpty ||
        user.gender.isEmpty) {
      throw Exception("All fields except interests are required.");
    }

    if (await emailExists(user.email)) {
      throw Exception("Email already registered");
    }

    return await db.insert('users', user.toMap());
  }

  ///  Fetch all users
  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users');
    return result.map((json) => UserModel.fromMap(json)).toList();
  }

  ///  Login User (Hash passwords in real-world cases)
  Future<bool> loginUser(String email, String password) async {
    final db = await instance.database;

    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password are required.");
    }

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await instance.database;

    // Ensure the email is valid before querying
    if (email.isEmpty) {
      throw Exception("Email is required to fetch user details.");
    }

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null; // Return null if user is not found
  }
}
