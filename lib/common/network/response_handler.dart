// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:xbridge/common/constants/api_constant.dart';

import 'custom_network_exception.dart';

class ResponseHandler {
  dynamic getResponseData(Response response, String url) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 401:
        var reponseJSON = json.decode(response.body.toString());
        return reponseJSON;
      // case 401:
      //   throw UnauthorisedException('something went wrong');
      default:
        throw FetchDataException('something went wrong');
    }
  }
}
