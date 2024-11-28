import 'dart:convert';

UserAuthTokenResponse temperaturesFromJson(String str) =>
    UserAuthTokenResponse.fromJson(json.decode(str));

String temperaturesToJson(UserAuthTokenResponse data) =>
    json.encode(data.toJson());

class UserAuthTokenResponse {
  String? accessToken;
  String? refreshToken;
  String? scope;
  String? tokenType;
  int? expiresIn;

  UserAuthTokenResponse({
    this.accessToken,
    this.refreshToken,
    this.scope,
    this.tokenType,
    this.expiresIn,
  });

  factory UserAuthTokenResponse.fromJson(Map<String, dynamic> json) =>
      UserAuthTokenResponse(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        scope: json["scope"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "scope": scope,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
