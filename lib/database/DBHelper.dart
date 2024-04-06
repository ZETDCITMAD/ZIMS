// ignore_for_file: deprecated_member_use

import 'dart:io' as io;
import 'dart:async';

import 'package:oms_mobile/models/pending_so.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // static DatabaseHelper _databaseHelper; //Singleton
  // static Database _database; //Singleton
  final serviceOrdersTable = "serviceOrder_table";

  //String serviceOrdersTable = 'serviceOrder_table';
  static Database db_instance;

  Future<Database> get db async {
    if (db_instance == null) {
      db_instance = await initDB();
    }
    return db_instance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "moms.db");
    var db = await openDatabase(path, version: 4, onCreate: onCreateFunc);
    return db;
  }
  // DatabaseHelper._createInstance();
  // factory DatabaseHelper() {
  //   if (_databaseHelper == null) {
  //     _databaseHelper = DatabaseHelper._createInstance();
  //   }
  //   return _databaseHelper;
  // }
  // Future<Database> get database async {
  //   if (_database == null) {
  //     _database = await initialiseDatabase();
  //   }
  //   return _database;
  // }

  // Future<Database> initialiseDatabase() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String path = directory.path + 'moms.db';

  //   var momsDatabase =
  //       await openDatabase(path, version: 4, onCreate: _createDb);
  //   return momsDatabase;
  // }

  void onCreateFunc(Database db, int version) async {
    // create table serviceorders
    await db.execute('''CREATE TABLE $serviceOrdersTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_id INTEGER,
        attendance_START TEXT,
        arrival_AT_LOCATION TEXT,
        fault_IDENTIFICATION TEXT,
        notes TEXT,
        weather_CONDITION TEXT,
        cause TEXT,
        so_CURRENT_STATUS TEXT       
         );''');
  }
  // void _createDb(Database db, int newVersion) async {
  //   // service orders DB
  //   await db.execute('''CREATE TABLE $serviceOrdersTable('
  //       id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       job_id TEXT,
  //       attendance_START TEXT,
  //       arrival_AT_LOCATION TEXT,
  //       fault_IDENTIFICATION TEXT,
  //       notes TEXT,
  //       weather_CONDITION TEXT,
  //       cause TEXT,
  //       so_CURRENT_STATUS TEXT,
  //       ')''');
  // }

  // CRUD functions Service orders

  // get service orders
  Future<List<PendingServiceOrder>> getServiceOrders() async {
    var db_connection = await db;

    List<Map> list =
        await db_connection.rawQuery('SELECT * FROM $serviceOrdersTable');
    List<PendingServiceOrder> serviceOrders = new List();

    for (var i = 0; i < list.length; i++) {
      PendingServiceOrder serviceOrder = new PendingServiceOrder();

      serviceOrder.job_id = list[i]['job_id'];
      serviceOrder.attendance_START = list[i]['attendance_START'];
      serviceOrder.arrival_AT_LOCATION = list[i]['arrival_AT_LOCATION'];
      serviceOrder.fault_IDENTIFICATION = list[i]['fault_IDENTIFICATION'];
      serviceOrder.notes = list[i]['notes'];
      serviceOrder.weather_CONDITION = list[i]['weather_CONDITION'];
      serviceOrder.cause = list[i]['cause'];
      serviceOrder.so_CURRENT_STATUS = list[i]['so_CURRENT_STATUS'];

      serviceOrders.add(serviceOrder);
    }
    return serviceOrders;
  }

  // get One service orders
  Future<List<PendingServiceOrder>> getOneServiceOrder({job_id}) async {
    var db_connection = await db;

    List<Map> list = await db_connection
        .rawQuery('SELECT * FROM $serviceOrdersTable WHERE job_id = $job_id');
    List<PendingServiceOrder> serviceOrders = new List();

    for (var i = 0; i < list.length; i++) {
      PendingServiceOrder serviceOrder = new PendingServiceOrder();

      serviceOrder.job_id = list[i]['job_id'];
      serviceOrder.attendance_START = list[i]['attendance_START'];
      serviceOrder.arrival_AT_LOCATION = list[i]['arrival_AT_LOCATION'];
      serviceOrder.fault_IDENTIFICATION = list[i]['fault_IDENTIFICATION'];
      serviceOrder.notes = list[i]['notes'];
      serviceOrder.weather_CONDITION = list[i]['weather_CONDITION'];
      serviceOrder.cause = list[i]['cause'];
      serviceOrder.so_CURRENT_STATUS = list[i]['so_CURRENT_STATUS'];

      serviceOrders.add(serviceOrder);
    }
    return serviceOrders;
  }

  // fetch service order data
  // Future<List<Map<String, dynamic>>> getServiceOrderMapList() async {
  //   Database db = await this.database;
  //   var result = await db.query(serviceOrdersTable);
  //   return result;
  // }

  // Add new Service order
  void addServiceOrder(PendingServiceOrder serviceOrder) async {
    var db_connection = await db;
    String sql = '''INSERT INTO $serviceOrdersTable(
          job_id,
          attendance_START,
          arrival_AT_LOCATION,
          fault_IDENTIFICATION,
          notes,
          weather_CONDITION,
          cause,
          so_CURRENT_STATUS
          
          ) VALUES(
            \'${serviceOrder.job_id}\',
            \'${serviceOrder.attendance_START}\',
            \'${serviceOrder.arrival_AT_LOCATION}\',
            \'${serviceOrder.fault_IDENTIFICATION}\',
            \'${serviceOrder.notes}\',
            \'${serviceOrder.weather_CONDITION}\',
            \'${serviceOrder.cause}\',
            \'${serviceOrder.so_CURRENT_STATUS}\'            
            )''';
    await db_connection.transaction((action) async {
      return await action.rawInsert(sql);
    });
  }

  // insert Data
  // Future<int> insertServiceOrder(PendingServiceOrder serviceOrder) async {
  //   Database db = await this.database;
  //   var result = await db.insert(serviceOrdersTable, serviceOrder.toMap());
  //   return result;
  // }

  // update service order
  void updateServiceOrderArrivalAtLocation(
      PendingServiceOrder serviceOrder) async {
    var db_connection = await db;
    String sql = '''UPDATE $serviceOrdersTable SET 
      
      arrival_AT_LOCATION =\'${serviceOrder.arrival_AT_LOCATION}\'
   
      WHERE job_id='${serviceOrder.job_id}' ''';
    await db_connection.transaction((action) async {
      return await action.rawQuery(sql);
    });
  }

  void updateServiceOrderFaultID(PendingServiceOrder serviceOrder) async {
    var db_connection = await db;
    String sql = '''UPDATE $serviceOrdersTable SET 
      
      fault_IDENTIFICATION =\'${serviceOrder.fault_IDENTIFICATION}\'
   
      WHERE job_id='${serviceOrder.job_id}' ''';
    await db_connection.transaction((action) async {
      return await action.rawQuery(sql);
    });
  }

  void updateServiceInexecution(PendingServiceOrder serviceOrder) async {
    var db_connection = await db;
    String sql = '''UPDATE $serviceOrdersTable SET 
      
      notes =\'${serviceOrder.notes}\',
      weather_CONDITION =\'${serviceOrder.weather_CONDITION}\',
      cause =\'${serviceOrder.cause}\',
      so_CURRENT_STATUS =\'${serviceOrder.so_CURRENT_STATUS}\'    
          
   
      WHERE job_id='${serviceOrder.job_id}' ''';
    await db_connection.transaction((action) async {
      return await action.rawQuery(sql);
    });

    // update data
    // Future<int> updateServiceOrder(PendingServiceOrder serviceOrder) async {
    //   Database db = await this.database;
    //   var result = await db.update(serviceOrdersTable, serviceOrder.toMap(),
    //       where: 'id=?', whereArgs: [serviceOrder.id]);
    //   return result;
    // }

    // update data
    // Future<int> updateServiceOrderSync(PendingServiceOrder serviceOrder) async {
    //   Database db = await this.database;
    //   var result = await db.update(serviceOrdersTable, serviceOrder.toMap(),
    //       where: 'status=?', whereArgs: ['pending']);
    //   return result;
    // }

    //  delete data
    // Future<int> deletePendingServiceOrder(int id) async {
    //   Database db = await this.database;
    //   var result =
    //       await db.rawInsert('DELETE FROM $serviceOrdersTable WHERE id = $id');
    //   return result;
    // }

    // Future<int> getCount() async {
    //   Database db = await this.database;
    //   List<Map<String, dynamic>> x =
    //       await db.rawQuery('SELECT COUNT (*) from $serviceOrdersTable');
    //   int result = Sqflite.firstIntValue(x);
    //   return result;
    // }

    // Future<List<PendingServiceOrder>> getServiceOrderList() async {
    //   var serviceOrderMapList = await getServiceOrderMapList();
    //   int count = serviceOrderMapList.length;
    //   List<PendingServiceOrder> serviceOrderList = List<PendingServiceOrder>();

    //   for (int i = 0; i < count; i++) {
    //     serviceOrderList
    //         .add(PendingServiceOrder.fromMapObject(serviceOrderMapList[i]));
    //   }
    //   return serviceOrderList;
    // }
  }

  // delete serviceorder
  void deleteServiceOrder(job_id) async {
    var db_connection = await db;
    String sql = 'DELETE FROM $serviceOrdersTable WHERE job_id = "$job_id"';
    await db_connection.transaction((action) async {
      return await action.rawQuery(sql);
    });
  }
}
