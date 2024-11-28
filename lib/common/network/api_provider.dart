// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/custom_network_exception.dart';
import 'package:xbridge/common/network/response_handler.dart';

import '../../sign_screen/data/models/sign_in_access_token_model.dart';
import '../constants/api_constant.dart';
import '../utils/shared_pref_helper.dart';

class APIProvider {
  ResponseHandler handler = ResponseHandler();
  late final RetryClient client;

  APIProvider() {
    client = RetryClient(
      http.Client(),
      retries: 1,
      when: (response) {
        return response.statusCode == 401;
      },
      onRetry: (req, res, retryCount) async {
        if (res?.statusCode == 401) {
          await refreshTokenAPI();
        }
      },
    );
  }

  Future<dynamic> getMethod(String url) async {
    var responseJson;
    try {
      String username = 'xbridge.testadmin';
      String password = 'Admin@123';
      String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      if (kDebugMode) {
        print("Request URL  : $url ");
      }
      final response = await client.get(
        Uri.parse(APIConstant.BASE_URL + url),
        headers: {
          'content-type': 'application/json',
          'authorization': headers['authorization'] ?? '',
        },
      );
      responseJson = handler.getResponseData(response, url);
      if (kDebugMode) {
        getJson(responseJson);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception("The request couldn't be processed. Please try again.");
    }
    return responseJson;
  }

  Future<dynamic> postMethod(String url, [Map request = const {}]) async {
    var responseJson;
    try {
      final response = await client.post(
        Uri.parse(APIConstant.BASE_URL + url),
        headers: headers,
        body: request,
      );
      responseJson = handler.getResponseData(response, url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Future<dynamic> postPushNotificationMethod([Map request = const {}]) async {
    var responseJson;
    try {
      final response = await client.post(
        Uri.parse(APIConstant.sendPushNotification),
        headers: {
          'content-type': 'application/json',
          'Authorization':
              'key=AAAAXhSNumk:APA91bHIsFbQMAdP0gAsv2_AEck_-v7aF3pd3252cm42wHBEfhfEGDEExhnT8kUhm60ZF3TvAKQN4elBeyQVhgYIUPO4GZ7j3mFvQwnGZXd75jYsD8j-qbuBCtO83iR09Alj7hGFYxp5',
        },
        body: request,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Future<dynamic> dytePostMethod(String url, {required String data}) async {
    var responseJson;
    try {
      final response = await client.post(
        Uri.parse(APIConstant.dyteBaseUrl + url),
        headers: dyteHeader,
        body: data,
      );
      responseJson = handler.getResponseData(response, url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Future<dynamic> uploadPDF(String url, {required String data}) async {
    var responseJson;
    try {
      final response = await client.post(
        Uri.parse(APIConstant.BASE_URL + url),
        headers: {
          'content-type': 'application/json',
          'authorization': headers['authorization'] ?? '',
        },
        body: data,
      );
      responseJson = handler.getResponseData(response, url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Future<dynamic> uploadAttachment(String url, {required File file}) async {
    var responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(APIConstant.BASE_URL + url));
      request.headers.addAll({
        'content-type': 'application/json',
        'authorization': headers['authorization'] ?? '',
      });
      final httpFile = await http.MultipartFile.fromPath(
        'uploadFile',
        file.path,
        filename: file.path.split('/').last,
      );
      request.fields['table_name'] = 'sys_user';
      request.fields['table_sys_id'] = userSysId;
      request.files.add(httpFile);

      final response = await request.send();
      var parsedRes = await http.Response.fromStream(response);
      responseJson = handler.getResponseData(parsedRes, url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Future<dynamic> putMethod(String url, {required String data}) async {
    var responseJson;
    // try {
    final response = await client.put(
      Uri.parse(APIConstant.BASE_URL + url),
      headers: {
        'content-type': 'application/json',
        'authorization': headers['authorization'] ?? '',
      },
      body: data,
    );
    responseJson = handler.getResponseData(response, url);
    // } on SocketException {
    //   throw FetchDataException('No Internet connection');
    // } catch (e) {
    //   throw Exception(
    //     'The request couldn't be processed. Please try again.',
    //   );
    // }
    return responseJson;
  }

  Future<dynamic> patchMethod(String url, {required String data}) async {
    var responseJson;
    try {
      final response = await client.patch(
        Uri.parse(APIConstant.BASE_URL + url),
        headers: {
          'content-type': 'application/json',
          'authorization': headers['authorization'] ?? '',
        },
        body: data,
      );
      responseJson = handler.getResponseData(response, url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Future<dynamic> deleteMethod(String url) async {
    var responseJson;
    try {
      final response = await client.delete(
        Uri.parse(APIConstant.BASE_URL + url),
        headers: headers,
      );
      responseJson = handler.getResponseData(response, url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }

  Map<String, String> headers = {
    'Accept': '*/*',
    // 'content-type': 'application/json',
  };

  Map<String, String> dyteHeader = {
    'content-type': 'application/json',
    'authorization':
        'Basic ${base64.encode(utf8.encode('4d96470c-b427-40a2-98bb-7609866d01aa:6124b42665d9b3d9d19a'))}',
  };

  void updateHeader({required String token}) {
    headers.addAll({'authorization': 'Bearer $token'});
  }

  Future<void> refreshTokenAPI() async {
    SharedPrefHelper prefHelper = GetIt.I.get<SharedPrefHelper>();
    String refreshToken = await prefHelper.get(
      SharedPrefHelper.refreshToken,
      defaultValue: '',
    );

    Map<dynamic, dynamic> request = {
      "grant_type": "refresh_token",
      "client_id": "daa0eed7266a3510badc09bc54152ab4",
      "client_secret": "E--7bHrCUQ",
      "refresh_token": refreshToken,
    };

    final response = await postMethod(APIConstant.API_Auth_Token, request);
    UserAuthTokenResponse result = UserAuthTokenResponse.fromJson(response);
    prefHelper.set(SharedPrefHelper.refreshToken, result.refreshToken ?? '');
    prefHelper.set(SharedPrefHelper.accessToken, result.accessToken ?? '');
    updateHeader(token: result.accessToken ?? '');
  }
}
