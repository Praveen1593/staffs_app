import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../staff/model/ExamDBModel.dart';
import '../staff/model/overall_exam_result_model.dart';

class DatabaseHelper{
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String studentsNameTable = 'students_name_table';
  String colId = 'id';
  String colStudentId = 'student_id';
  String colCode = 'code';
  String colFullName = 'full_name';
  String colGender = 'gender_id';
  String colCategoryName = 'category_id';
  String colAcademicId = 'academic_id';
  String colBoardId = 'board_id';

  factory DatabaseHelper(){
    if(_databaseHelper!=null){
      _databaseHelper = DatabaseHelper();
    }

    return _databaseHelper!;
  }

  Future<Database> get database async{

    if(_database!=null){
      _database = await initializeDatabase();
    }

    return _database!;
  }

  Future<Database> initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'exam.db';

    //Open/Create the database at a given path
    var examDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return examDatabase;
  }

  void _createDb(Database db, int newVersion)async{

    await db.execute('CREATE TABLE $studentsNameTable($colStudentId INTEGER PRIMARY KEY, $colCode TEXT, $colFullName TEXT,'
        '$colGender TEXT, $colCategoryName TEXT, $colAcademicId INTEGER, $colBoardId INTEGER)');

  }

  // Fetch Operation: Get all note objects from database
  /*Future<List<OverallExamResultData>>  getNoteMapList() async{
    List<OverallExamResultData> dd = [];
    Database db = await this.database;

    var dd = await db.query(studentsNameTable);
    return dd;
  }*/

  // Insert Operation: Insert a Note object to database
  /*Future<int> insertItem(List<OverallExamResultData> examDBModel) async {
    Database db = await this.database;
    var result = await db.insert(studentsNameTable, examDBModel);
    return result;
  }*/

  // Update Operation: Update a note object and save it to database
  Future<int> updateItem(ExamDbModel examDBModel,int index) async {
    Database db = await this.database;
    var result = await db.update(studentsNameTable, examDBModel.toJson(), where: '$colStudentId = ?', whereArgs: [examDBModel.data[index].studentId]);
    return result;
  }

  // Delete Operation: Delete a note objects from database
  Future<int> deleteItem(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $studentsNameTable WHERE $colStudentId = $id');
    return result;
  }

  // Get number of Note objects in database


}