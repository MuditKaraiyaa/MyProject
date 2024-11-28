import 'dart:convert';

import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';
import 'package:xbridge/fieldengineer/data/model/field_engineer_detail_entity.dart';
import 'package:xbridge/sign_screen/data/models/sign_in_access_token_model.dart';
import 'package:xbridge/sign_screen/data/models/sign_in_response_model.dart';

import '../../../common/constants/globals.dart';
import '../../../common/utils/util.dart';
import '../../../main.dart';

abstract class SignInRepository {
  Future<SignInResponse> verifyUser(String email, String password);
  Future<UserAuthTokenResponse> getAccessToken();
  Future<FieldEngineerDetailResult> updateUserDeviceToken(
    String? userId,
    String? deviceToken,
  );
}

class SignInRepositoryImpl implements SignInRepository {
  final APIProvider provider;
  final SharedPrefHelper prefHelper;

  SignInRepositoryImpl({required this.provider, required this.prefHelper});

  @override
  Future<SignInResponse> verifyUser(String email, String password) async {
    await provider.refreshTokenAPI();
    // logger.f("${APIConstant.API_Login}username=$email&password=$password");
    final response = await provider.getMethod(
      "${APIConstant.API_Login}username=$email&password=$password",
    );
    logger.i("Response : ${getJson(response)}");

    SignInResponse result = SignInResponse.fromJson(response);
    if (result.result.result == "success") {
      logger.i("Username : ${result.result.userName}");

      await prefHelper.set(SharedPrefHelper.userName, result.result.userName);
      await prefHelper.set(
        SharedPrefHelper.vendorName,
        result.result.vendorName,
      ); // Saving vendorName
      await prefHelper.set(SharedPrefHelper.firstName, result.result.firstName);
      await prefHelper.set(SharedPrefHelper.agentType, result.result.agentType);
      await prefHelper.set(SharedPrefHelper.userSysId, result.result.sysId);
      await prefHelper.set(SharedPrefHelper.lastName, result.result.lastName);
      // userName = result.result.userName;
      // vendorName = result.result.vendorName;
    }
    return result;
  }

  @override
  Future<UserAuthTokenResponse> getAccessToken() async {
    Map<dynamic, dynamic> request = {
      "grant_type": "password",
      "client_id": "daa0eed7266a3510badc09bc54152ab4",
      "client_secret": "E--7bHrCUQ",
      "username": "xbridge.restuser",
      "password": "Welcome@123",
    };

    final response = await provider.postMethod(APIConstant.API_Auth_Token, request);
    UserAuthTokenResponse result = UserAuthTokenResponse.fromJson(response);
    prefHelper.set(SharedPrefHelper.refreshToken, result.refreshToken ?? '');
    prefHelper.set(SharedPrefHelper.accessToken, result.accessToken ?? '');
    provider.updateHeader(token: result.accessToken ?? '');
    return result;
  }

  @override
  Future<FieldEngineerDetailResult> updateUserDeviceToken(
    String? userId,
    String? deviceToken,
  ) async {
    final response = await provider.putMethod(
      APIConstant.updateUserDetailsApi + userId!,
      data: jsonEncode({
        "u_xbl_device_token": deviceToken,
      }),
    );
    FieldEngineerDetailResult result = FieldEngineerDetailResult.fromJson(response);

    return result;
  }
}
