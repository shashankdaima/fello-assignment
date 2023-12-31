// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/services/db_services/dao/task_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'entities/task_entity.dart';

part 'app_db.g.dart'; // the generated code will be there

final appDbProvider = Provider((ref) async =>
    await $FloorAppDatabase.databaseBuilder('app_database.db').build());

@Database(version: 1, entities: [TaskEntity])
abstract class AppDatabase extends FloorDatabase {
  TasksDao get taskDao;
}
