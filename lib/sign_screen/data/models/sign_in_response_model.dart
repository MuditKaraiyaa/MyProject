/*
class User {
  String? email;

  User({this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(email: json['email']);

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class SignInResponse {
  String? status;
  ErrorResponse? errorResponse;

  SignInResponse({this.status, this.errorResponse});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorResponse = json['errorResponse'];
  }
}

class ErrorResponse {
  String? errorCode;
  String? errorMessage;

  ErrorResponse({this.errorCode, this.errorMessage});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        errorCode: json['errorCode'],
        errorMessage: json['errorMessage'],
      );
}
*/
// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) => SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  Result result;

  SignInResponse({
    required this.result,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class Result {
  String result;
  String userName;
  String vendorName;
  String agentType;
  String message;
  String firstName;
  String lastName;
  String sysId;

  Result({
    required this.result,
    required this.userName,
    required this.vendorName,
    required this.agentType,
    required this.message,
    required this.firstName,
    required this.lastName,
    required this.sysId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        result: json["result"],
        userName: json["userName"],
        agentType: json["agentType"] ?? "",
        message: json["message"],
        firstName: json['firstName'],
        lastName: json['lastName'],
        sysId: json['sysId'],
        vendorName: json['vendorName'],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "userName": userName,
        "vendorName": vendorName,
        "agentType": agentType,
        "message": message,
        "firstName": firstName,
        "lastName": lastName,
        "sysId": sysId,
      };
}
