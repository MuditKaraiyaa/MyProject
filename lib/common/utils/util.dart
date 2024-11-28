import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/offline/model/offline_table.dart';
import 'package:xbridge/common/utils/geofence_helper.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';
import 'package:xbridge/dashboard/data/model/dashboard.model.dart';
import 'package:xbridge/fieldengineer/data/model/field_engineer_detail_entity.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_field_engineer_entity.dart';
import 'package:xbridge/task_details/data/repositories/task_details_repositories.dart';
import 'package:xbridge/unassigned_visits/data/model/unassigned_task_entity.dart';

import '../../my_team/data/model/my_team_entity.dart';
import '../network/api_provider.dart';

Size getDeviceSize(BuildContext context) {
  return const Size(390, 844);
}

String getBaseURL() {
  return "";
}

String getLocalTime({required String date}) {
  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('hh:mm a').format(dateTime);
  } catch (e) {
    return "";
  }
}

Future<void> setupInjections() async {
  GetIt.I.registerLazySingleton<APIProvider>(() => APIProvider());
  GetIt.I.registerLazySingleton<SharedPrefHelper>(() {
    SharedPrefHelper helper = SharedPrefHelper();
    return helper;
  });
  await GetIt.I<SharedPrefHelper>().init();
  GetIt.I.registerLazySingleton<GeoFenceHelper>(() {
    GeoFenceHelper helper = GeoFenceHelper(
      repository: TaskDetailsRepositoryImpl(
        provider: GetIt.I.get<APIProvider>(),
      ),
    );
    helper.init();
    return helper;
  });
}

extension XDateTime on DateTime {
  String get onlyDate => '$day-$month-$year';
}

Future<void> addToDatabase(
  String tableName,
  Type model,
  dynamic obj, {
  String? identifierName = "sys_id",
  String? identifier,
  var taskStatus,
}) async {
  var addedRecord = await getLocalData(
    tableName,
    model,
    identifierName: identifierName,
    identifier: identifier,
    taskStatus: taskStatus,
  );
  if (addedRecord == null) {
    Directory directory = await getApplicationDocumentsDirectory();

    String dbPath = '${directory.path}/xbridge.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);
    var myStore = intMapStoreFactory.store(tableName);
    Object? record;
    if (taskStatus != null) {
      record = await myStore.record(taskStatus).put(db, obj.toJson());
    } else {
      try {
        var key = await myStore.add(db, obj.toJson());
        record = await myStore.record(key).getSnapshot(db);
      } catch (e) {
        var key = await myStore.add(db, obj);
        record = await myStore.record(key).getSnapshot(db);
      }
    }

    if (kDebugMode) {
      print("------The record has been added in local DB------ : $record");
    }
  }
}

Future<dynamic> flushDatabase() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  dbFactory.deleteDatabase(dbPath);
}

Future<dynamic> deleteTableFromDatabase(String tableName) async {
  if (isInternetAvailable) {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = '${directory.path}/xbridge.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);
    var myStore = intMapStoreFactory.store(tableName);
    await myStore.drop(db);
  }
}

Future<dynamic> getLocalData(
  String tableName,
  Type model, {
  String? identifierName = "sys_id",
  String? identifier,
  var taskStatus,
}) async {
  Directory directory = await getApplicationDocumentsDirectory();

  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var myStore = intMapStoreFactory.store(tableName);
  var finder = Finder(
    filter: Filter.equals(
      (tableName == Constants.tblManagerTaskFEUserDetails)
          ? identifierName ?? ""
          : 'result.$identifierName',
      identifier,
    ),
  );

  dynamic recordSnap;

  if (taskStatus != null) {
    recordSnap = await myStore.record(taskStatus).get(db); //as Map;

    if (recordSnap != null) {
      if (kDebugMode) {
        print("------Found from local database------");
      }
      if (model == UnassignedTaskEntity) {
        final result = UnassignedTaskEntity.fromJson(recordSnap);
        return result;
      }
    }
  } else {
    recordSnap =
        myStore.findSync(db, finder: (identifier == null) ? null : finder);
  }
  if (recordSnap == null) {
    if (kDebugMode) {
      print("------No local record found------");
    }
    return null;
  }

  var records = recordSnap.map((snapshot) {
    if (model == MyTeamEntity) {
      final result = MyTeamEntity.fromJson(snapshot.value);
      return result;
    } else if (model == UnassignedTaskEntity) {
      final result = UnassignedTaskEntity.fromJson(snapshot.value);
      return result;
    } else if (model == TaskDetailEntity) {
      final result = TaskDetailEntity.fromJson(snapshot.value);
      return result;
    } else if (model == CaseDetailEntity) {
      final result = CaseDetailEntity.fromJson(snapshot.value);
      return result;
    } else if (model == TaskFieldEngineerEntity) {
      final result = TaskFieldEngineerEntity.fromJson(snapshot.value);
      return result;
    } else if (model == FieldEngineerDetailEntity) {
      final result = FieldEngineerDetailEntity.fromJson(snapshot.value);
      return result;
    } else if (model == DashboardResult) {
      final result = DashboardResult.fromJson(snapshot.value);
      return result;
    }
  });

  if (records.isEmpty) {
    if (kDebugMode) {
      print("------No local record found------");
    }
    return null;
  } else {
    if (kDebugMode) {
      print("------Found from local database------");
      // print(records.first);
    }
    return records.first;
  }
}

bool validateEmail(String value) {
  final RegExp nameExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  return nameExp.hasMatch(value);
}

Future<void> removeUnSyncedAPI(
  UnsyncAPI obj,
) async {
  Directory directory = await getApplicationDocumentsDirectory();
  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var myStore = intMapStoreFactory.store(Constants.tblOfflinePendingAPI);
  Object? record;

  var finder = Finder(
    filter: Filter.equals('apiName', obj.apiName ?? ""),
  );

  await myStore.delete(
    db,
    finder: finder,
  );
  if (kDebugMode) {
    print("------The API data has been removed------ : ${obj.apiName ?? " "}");
  }
}

Future<void> addToUnSyncedAPITable(
  UnsyncAPI obj,
) async {
  Directory directory = await getApplicationDocumentsDirectory();
  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var myStore = intMapStoreFactory.store(Constants.tblOfflinePendingAPI);
  Object? record;

  var finder = Finder(
    filter: Filter.equals('apiName', obj.apiName ?? ""),
  );

  await myStore.delete(
    db,
    finder: finder,
  );

  try {
    var key = await myStore.add(db, obj.toJson());
    record = await myStore.record(key).getSnapshot(db);
  } catch (e) {
    if (kDebugMode) {
      print("Exception : $e");
    }
  }

  if (kDebugMode) {
    print(
      "------The Unsync API record has been added in local DB------ : $record",
    );
  }
  getUnsyncAPIData();
}

Future<List<UnsyncAPI>?> getUnsyncAPIData() async {
  Directory directory = await getApplicationDocumentsDirectory();

  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var myStore = intMapStoreFactory.store(Constants.tblOfflinePendingAPI);
  var finder = Finder(
    filter: Filter.equals('isSync', false),
  );

  dynamic recordSnap;

  recordSnap = myStore.findSync(db, finder: finder);
  if (recordSnap == null) {
    if (kDebugMode) {
      print("------No Unsync API local record found------");
    }
    return null;
  }

  List<UnsyncAPI> resultListData = [];

  for (var imageAsset in recordSnap) {
    final result = UnsyncAPI.fromJson(imageAsset.value);
    resultListData.add(result);
  }

  if (resultListData.isEmpty) {
    if (kDebugMode) {
      print("------No local record found------");
    }
    return null;
  } else {
    if (kDebugMode) {
      print("------Found from local database------");
      print(resultListData);
    }
    return resultListData;
  }
}

Future<dynamic> deleteTableByKeyFromDatabase(String tableName, int key) async {
  Directory directory = await getApplicationDocumentsDirectory();
  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var myStore = intMapStoreFactory.store(tableName);
  var record = myStore.record(key);
  await record.delete(db);
}

Future<dynamic> updateLocalTaskDB(var taskStatus, String taskNumber) async {
  Directory directory = await getApplicationDocumentsDirectory();

  String dbPath = '${directory.path}/xbridge.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var myStore = intMapStoreFactory.store(Constants.tblFETaskList);

  dynamic recordSnap;

  if (taskStatus != null) {
    recordSnap = await myStore.record(taskStatus).get(db); //as Map;

    if (recordSnap != null) {
      if (kDebugMode) {
        print("------Found from local database------");
      }
      final result = UnassignedTaskEntity.fromJson(recordSnap);
      var intFoundResultIndex =
          result.result?.indexWhere((element) => element.number == taskNumber);
      if (intFoundResultIndex != null) {
        result.result?[intFoundResultIndex].state = "In Progress";
      }
      await myStore.record(taskStatus).put(db, result.toJson());
    }
  }
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page))
      .then((value) {
    currentActiveChatGroupId = "";
  });
}

/// Indicator for check if FE has reached under task radius.
final geofenceStatusValueNotifier = ValueNotifier(GeofenceStatus.DWELL);

final feTaskListNewTabRefreshIndicator = ValueNotifier(false);

void showLoading({
  required bool value,
  String? title = "Loading..",
  bool closeOverlays = false,
}) {
  if (value) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..maskColor = Colors.black12

      /// custom style
      ..loadingStyle = EasyLoadingStyle.custom
      ..progressColor = AppColors.red
      ..indicatorColor = AppColors.red
      ..backgroundColor = Colors.white
      ..textColor = Colors.black

      ///
      ..userInteractions = false
      ..animationStyle = EasyLoadingAnimationStyle.offset;
    EasyLoading.show(
      maskType: EasyLoadingMaskType.custom,
      status: title,
      dismissOnTap: kDebugMode,
    );
  } else {
    EasyLoading.dismiss();
  }
}
