import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_floor/dao/persondao.dart';
import 'package:flutter_floor/model/person.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
}
