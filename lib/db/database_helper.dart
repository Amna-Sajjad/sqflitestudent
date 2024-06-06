import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/student.dart';

class DatabaseHelper{
  DatabaseHelper._internal();
  static final DatabaseHelper helper = DatabaseHelper._internal();
  static Database? _database;

  //getter for database

  Future<Database> get database async{
    _database ??= await initializadatabase(); //if database is null then create database else return it
    return _database!;
  }
  Future<Database> initializadatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/student.db";
    var studentDatabase = openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
    return studentDatabase;
  }
  void _createTable(Database db, int newVersion) async{
    await db.execute('''CREATE TABLE student(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    course TEXT,
    mobile INT,
    totalFee INT,
    paidFee INT)
    ''');
  }

  //insert into table
  Future<int> insertStudent(Student student) async{
    Database db = await helper.database;
    int result = await db.insert("student", student.toMap());
    return result;
  }

  //get from table
  Future<List<Student>> getAllStudents() async{
    Database db = await helper.database;
    List<Student> allStudents = [];
    List<Map<String, dynamic>> studentMap = await db.query("Student");

    for(var std in studentMap){
      Student student = Student.fromMap(std);
      allStudents.add(student);
    }
    return allStudents;
  }

  //delete student
  Future<int> deleteStudent(int id) async{
    Database db = await helper.database;
    int result = await db.delete("Student", where: 'id=?', whereArgs: [id]);
    return result;
  }

  //update student record
  Future<int> updateStudent(Student student) async{
    Database db = await helper.database;
    int result = await db.update("Student", student.toMap(), where: 'id=?', whereArgs: [student.id]);
    return result;
  }

}