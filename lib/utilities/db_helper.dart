import 'dart:io';

import 'package:activitysql1/models/to_do_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

String tableName ="to_do_lsit_table";
String id="id";
String name="name";
String branch="branch";
String address="address";
String image="image";

class DataBaseHelper{
  static late DataBaseHelper _dataBaseHelper;
  late Database _database;
  DataBaseHelper._createInstance();

  factory DataBaseHelper(){
    _dataBaseHelper = DataBaseHelper._createInstance();
    return _dataBaseHelper;
  }

  get database async{
    _database = await initalizeDatabase();
    return _database;

  }

  Future<Database>initalizeDatabase() async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path= "${directory.path}my_todo_list_database.db";
    return await openDatabase(path,version: 1,onCreate: _create);
  }

  _create(Database database,int version) async{
    return await database.execute("CREATE TABLE $tableName ($id INTEGER PRIMARY KEY ,$name TEXT,$branch TEXT,$address TEXT,$image TEXT )");
  }
  Future<int> insertItem(ToDoModel toDoModel ) async{
    Database database= await this.database;
    var results=database.insert(tableName, toDoModel.toMap(),);
    // print("Data Inserted");
    return results;
  }
  Future<List<Map<String,dynamic>>>getDatainMaps() async{
    Database database=await this.database;
    return database.query(tableName);
  }
  Future<List<ToDoModel>> getModelsFromMapList() async{
    List<Map<String,dynamic>> mapList = await getDatainMaps();
    List<ToDoModel> toDoListModel= [];
    for(int i=0;i<mapList.length;i++){
      toDoListModel.add(ToDoModel.fromMap(mapList[i]));
    }
    return toDoListModel;
  }
  Future<int> updateItem(ToDoModel toDoModel) async{
    Database database =  await this.database;
    return database.update(tableName, toDoModel.toMap(),where: "$id=?",whereArgs: [toDoModel.id] );
  }

  Future<int> deleteItem(ToDoModel toDoModel) async {
    Database database = await this.database;
    return database.delete(tableName, where: "$id = ? ", whereArgs: [toDoModel.id]);
  }

}