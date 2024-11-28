import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:xbridge/common/constants/globals.dart';

import '../../../common/constants/api_constant.dart';
import '../../../common/network/api_provider.dart';
import '../../../fieldengineer/data/model/field_engineer_detail_entity.dart';

abstract class LocationRepository {
  Future<FieldEngineerDetailResult> updateUserLocation(
      {required Position position});
}

class LocationRepositoryImpl implements LocationRepository {
  final APIProvider provider;

  LocationRepositoryImpl({
    required this.provider,
  });

  @override
  Future<FieldEngineerDetailResult> updateUserLocation(
      {required Position position}) async {
    final response = await provider.putMethod(
      APIConstant.updateUserDetailsApi + userSysId,
      data: jsonEncode({
        "u_last_latitude": "${position.latitude}",
        "u_last_longitude": "${position.longitude}"
      }),
    );
    FieldEngineerDetailResult result =
    FieldEngineerDetailResult.fromJson(response['result']);

    return result;
  }
}
