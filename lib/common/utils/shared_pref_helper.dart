import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  //Keys
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String enableLocation = 'enable_location';
  static const String userName = 'user_name';
  static const String vendorName = 'vendorName';
  static const String firstName = 'first_name';
  static const String agentType = 'agent_type';
  static const String userSysId = 'sysId';
  static const String lastName = 'lastName';
  static const bool isInternetAvailable = false;

  late final SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // For plain-text data
  Future<void> set(String key, dynamic value) async {
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }

  //Method for get from any key
  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    return sharedPreferences.get(key) ?? defaultValue;
  }

  // For logging out
  Future<void> deleteAll() async {
    await sharedPreferences.remove(accessToken);
    await sharedPreferences.remove(refreshToken);
  }
}
