// import 'package:xbridge/generated/json/base/json_convert_content.dart';
// import 'package:xbridge/my_team/data/model/my_team_entity.dart';
//
// MyTeamEntity $MyTeamEntityFromJson(Map<String, dynamic> json) {
//   final MyTeamEntity myTeamEntity = MyTeamEntity();
//   final List<MyTeamResult>? result = (json['result'] as List<dynamic>?)?.map(
//           (e) => jsonConvert.convert<MyTeamResult>(e) as MyTeamResult).toList();
//   if (result != null) {
//     myTeamEntity.result = result;
//   }
//   return myTeamEntity;
// }
//
// Map<String, dynamic> $MyTeamEntityToJson(MyTeamEntity entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['result'] = entity.result?.map((v) => v.toJson()).toList();
//   return data;
// }
//
// extension MyTeamEntityExtension on MyTeamEntity {
//   MyTeamEntity copyWith({
//     List<MyTeamResult>? result,
//   }) {
//     return MyTeamEntity()
//       ..result = result ?? this.result;
//   }
// }
//
// MyTeamResult $MyTeamResultFromJson(Map<String, dynamic> json) {
//   final MyTeamResult myTeamResult = MyTeamResult();
//   final String? userSysId = jsonConvert.convert<String>(json['user.sys_id']);
//   if (userSysId != null) {
//     myTeamResult.userSysId = userSysId;
//   }
//   final String? userName = jsonConvert.convert<String>(json['user.name']);
//   if (userName != null) {
//     myTeamResult.userName = userName;
//   }
//   final String? userUTypeOfUser = jsonConvert.convert<String>(
//       json['user.u_type_of_user']);
//   if (userUTypeOfUser != null) {
//     myTeamResult.userUTypeOfUser = userUTypeOfUser;
//   }
//   final String? userUserName = jsonConvert.convert<String>(
//       json['user.user_name']);
//   if (userUserName != null) {
//     myTeamResult.userUserName = userUserName;
//   }
//   return myTeamResult;
// }
//
// Map<String, dynamic> $MyTeamResultToJson(MyTeamResult entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['user.sys_id'] = entity.userSysId;
//   data['user.name'] = entity.userName;
//   data['user.u_type_of_user'] = entity.userUTypeOfUser;
//   data['user.user_name'] = entity.userUserName;
//   return data;
// }
//
// extension MyTeamResultExtension on MyTeamResult {
//   MyTeamResult copyWith({
//     String? userSysId,
//     String? userName,
//     String? userUTypeOfUser,
//     String? userUserName,
//   }) {
//     return MyTeamResult()
//       ..userSysId = userSysId ?? this.userSysId
//       ..userName = userName ?? this.userName
//       ..userUTypeOfUser = userUTypeOfUser ?? this.userUTypeOfUser
//       ..userUserName = userUserName ?? this.userUserName;
//   }
// }