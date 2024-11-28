import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';
import 'package:xbridge/location_update/data/models/field_engineer_model.dart';

import '../../main.dart';
import '../utils/util.dart';

/// Function to check if user is logged in
Future<bool> isUserLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? loggedInUserName = prefs.getString(SharedPrefHelper.userName);
  final String? loggedInUserFirstName = prefs.getString(SharedPrefHelper.firstName);
  final String? loggedInUserLastName = prefs.getString(SharedPrefHelper.lastName);
  final String? loggedInAgentType = prefs.getString(SharedPrefHelper.agentType);
  final String? loggedInUserId = prefs.getString(SharedPrefHelper.userSysId);
  final String? loggedInVendorName = prefs.getString(SharedPrefHelper.vendorName);


  logger.i("loggedInUserName : $loggedInUserName ");

  userName = loggedInUserName ?? "";
  firstName = loggedInUserFirstName ?? "";
  lastName = loggedInUserLastName ?? "";
  userSysId = loggedInUserId ?? "";
  vendorName = loggedInVendorName ?? "";

  userType = loggedInAgentType == "Field Engineer"
      ? UserType.fe
      : loggedInAgentType == "SD Agent"
          ? UserType.agent
          : UserType.fm;

  // Return true if loggedInUserName is not null and not empty
  return loggedInUserName != null && loggedInUserName.isNotEmpty;
}

/// Function to get the full name of the logged-in user
Future<String> getUserFullLastName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? loggedInUserFirstName = prefs.getString(SharedPrefHelper.firstName);
  final String? loggedInUserLastName = prefs.getString(SharedPrefHelper.lastName);

  return '$loggedInUserFirstName $loggedInUserLastName';
}

/// Value Notifier for Internet connectivity
final isOffline = ValueNotifier(false);

/// Function to check if an email is valid
bool isEmailValid(String email) {
  return RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  ).hasMatch(email);
}

/// Enum defining user types
enum UserType { fe, fm, agent }

var taskNumber = "";
var currentTaskStatus = 0;
String taskId = "";
bool isPasswordValid(String password) => password.length >= 6;
bool isUserActive = false;
String userName = "";
String vendorName = "";
String databaseName = "FCM.db";
String firstName = "";
String receiverMsgId = "";
String userSysId = "";
String lastName = "";
Position? userLastPosition;
String currentActiveChatGroupId = "";
String fieldEngineer = "fieldEngineer";
ValueNotifier<int> tabBarIndex = ValueNotifier(2);

String email = "email";
String latitude = "latitude";
String longitude = "longitude";
UserType userType = UserType.fm;
bool isInternetAvailable = true;
int closedStatus = 3;
int etaProvidedStatus = 4;
int engineerPartReachStatus = 5;
int pendingCustomerStatus = 6;
int additionalVisitStatus = 8;
int openNewTaskStatus = 1;
int taskStatusByType = 1;
int inProgressAcceptedTaskStatus = 9;
int completeTaskStatus = 10;
int cancelledTaskStatus = 11;
int inCompleteTaskStatus = 111;
int allTaskStatus = 000;
int acceptedTaskStatus = 101;
String userDeviceToken = '';
const String tempFEEmail = "fe@gmail.com";

const String dashboardMyTeam = "My Team";
const String dashboardVisit = "Tasks";
const String dashboardDiagnostic = "Contact Support";
const String dashboardCalendar = "Calendar";
const String dashboardLogs = "Logs";
const String dashboardSettings = "Settings";

/// Function to get screen width
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// Function to get screen height
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Function to get the path of the app's databases
Future<String> getAppDatabasesPath() async {
  var databasesPath = await getDatabasesPath();
  return join(databasesPath, databaseName);
}

/// Widget to create a spacer with given height
Widget getSpacer(int height) {
  return SizedBox(
    height: height.h,
  );
}

/// Function to show a toast message
void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// Get a location using getDatabasesPath
initDatabase() async {
  await openDatabase(
    await getAppDatabasesPath(),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE $fieldEngineer (id INTEGER PRIMARY KEY autoincrement, $email TEXT, $latitude TEXT, $longitude TEXT)",
      );
    },
    version: 1,
  );
}

void getDeviceToken() {
  FirebaseMessaging.instance.getToken().then((value) {
    userDeviceToken = value ?? "";
    logger.i("Device Token : $value");
  });
}

Future<void> insertRecordInFEForLocation(FieldEngineerModel engineer) async {
  Database database = await openDatabase(await getAppDatabasesPath(), version: 1);
  // Insert some records in a transaction
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
      'INSERT INTO $fieldEngineer($email) VALUES(${engineer.email})',
    );

    if (kDebugMode) {
      print('inserted field engineer Vinay : $id1');
    }
  });
  await database.close();
  getRecordFromFETable();
}

Future<void> updateRecordInFEForLocation(FieldEngineerModel engineer) async {
  Database database = await openDatabase(await getAppDatabasesPath(), version: 1);
// Update some record
  int count = await database
      .rawUpdate('UPDATE $fieldEngineer SET $latitude = ?, $longitude = ? WHERE $email = ?', [
    {engineer.latitude ?? ""},
    {engineer.longitude ?? ""},
    {engineer.email ?? ""},
  ]);

  if (kDebugMode) {
    print('updated: $count');
  }
  await database.close();
  getRecordFromFETable();
}

Future<void> getRecordFromFETable() async {
  Database database = await openDatabase(await getAppDatabasesPath(), version: 1);
  List<Map> list = await database.rawQuery('SELECT * FROM  $fieldEngineer');

  if (kDebugMode) {
    print('Field Engineer Records fetched : $list');
  }
  await database.close();
}

Future<void> deleteRecordFromFETable(FieldEngineerModel engineerModel) async {
  Database database = await openDatabase(await getAppDatabasesPath(), version: 1);
// Delete a record
  var count = await database.rawDelete('DELETE FROM $fieldEngineer WHERE $email = ?', [
    {engineerModel.email},
  ]);
  assert(count == 1);

// Close the database
  await database.close();

  getRecordFromFETable();
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
      (index) => Event('Event $item | ${index + 1}'),
    ),
}..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 100, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 100, kToday.month, kToday.day);
void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

String getJson(jsonObject, {name}) {
  var encoder = const JsonEncoder.withIndent("     ");
  log(encoder.convert(jsonObject), name: name ?? "");
  return encoder.convert(jsonObject);
}

extension DateUtils on DateTime {
  bool get isJustNow {
    final now = DateTime.now();
    return now.difference(this).inMinutes <= 10 &&
        now.hour == hour &&
        now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  bool get isEarlierThisWeek {
    final earlier = DateTime.now().subtract(const Duration(days: 3));
    return earlier.day == day && earlier.month == month && earlier.year == year;
  }

  bool get isLastWeek {
    final lastWeek = DateTime.now().subtract(const Duration(days: 7));
    return lastWeek.day == day && lastWeek.month == month && lastWeek.year == year;
  }
}

/// App Tab Index
final selectedIndexNotifier = ValueNotifier(2);
