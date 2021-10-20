import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/monster.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'monsters.db');
    
    return await openDatabase(
      path,
      version: 1,
      onConfigure: onConfigure,
      onCreate: _onCreate,
    );
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE monsters(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        bodyType VARCHAR(10) NOT NULL,
        eyesCount INT,
        limbsCount INT,
        status INT CHECK( LENGTH(status) <= 1) NOT NULL DEFAULT 0
      )
    ''');

    
    await db.execute('''
      CREATE TABLE monster_extra(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id_monster INTEGER,
        extra_feature VARCHAR(10) NOT NULL,
        FOREIGN KEY (id_monster) REFERENCES monsters(id) ON DELETE CASCADE
      )
    ''');

    
    await db.execute('''
      CREATE VIEW monster_view AS
      SELECT
      a.id,
      a.bodytype as bodyType,
      a.eyescount as eyesCount,
      a.limbscount as limbsCount,
      a.status as status,
      GROUP_CONCAT(b.extra_feature,', ') as extra_feature
      FROM monsters a
      LEFT JOIN monster_extra b ON a.id = b.id_monster
      GROUP BY(a.id)
    ''');
  }


  Future<List<Monster>> getMonster() async {
    Database db = await instance.database;
    List monsters = await db.query('monster_view', orderBy: 'id');
    

    List<Monster> monsterList = monsters.isNotEmpty 
    ? monsters.map((monster) => Monster.fromMap(monster)).toList()
    :[];
    
    return monsterList;
  }

  Future<Map<String,int>> add(Monster monster) async{
    Database db = await instance.database;

    int idMonster = await db.insert('monsters',monster.mainFeaturesMap());
    
    List<Map<String,dynamic>> extraFeatures  = monster.extraFeaturesMap();

    if(extraFeatures.isEmpty){
      return {
        'idMonster':idMonster
      };
    }
    for (var feature in extraFeatures) {
      feature['id_monster'] = idMonster;
      await db.insert('monster_extra',{
        'id_monster':idMonster,
        'extra_feature':feature['extra_feature']
      });
    }
    
    return {
      'idMonster':idMonster
    };
  }

  Future<int> remove(int? id) async{
    Database db = await instance.database;
    return await db.delete('monsters',where: 'id = ?',whereArgs: [id]);
  }

  Future<int> updateStatus(updatedData,int? id) async{
    Database db = await instance.database;
    return await db.update('monsters',updatedData,where: 'id = ?',whereArgs: [id]);
  }

  Future update(Monster monster, int id) async{
    Database db = await instance.database;
    
    int idMonster = await db.update('monsters',monster.mainFeaturesMap(),where: 'id = ?',whereArgs: [id]);
    await db.delete('monster_extra',where: 'id_monster = ?',whereArgs: [idMonster]);

    monster.extraFeaturesMap().forEach((feature) async {
      feature['id'] = idMonster;
      await db.insert('monster_extra',feature);
    });

    return {
      'idMonster':idMonster
    };


  } 


  
}

