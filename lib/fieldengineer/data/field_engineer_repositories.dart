import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/utils/util.dart';

import '../../common/constants/api_constant.dart';
import '../../common/network/api_provider.dart';
import 'model/field_engineer_detail_entity.dart';

abstract class FieldEngineerRepository {
  Future<FieldEngineerDetailEntity> getEngineerDetail({required String id});
}

class FieldEngineerRepositoryImpl extends FieldEngineerRepository {
  final APIProvider provider;
  FieldEngineerRepositoryImpl({required this.provider});

  @override
  Future<FieldEngineerDetailEntity> getEngineerDetail({
    required String id,
  }) async {
    // final response = await provider.getMethod(APIConstant.userDetail + id);
    // return FieldEngineerDetailEntity.fromJson(response);

    var addedRecord = await getLocalData(
      Constants.tblManagerTaskFEUserDetails,
      FieldEngineerDetailEntity,
      identifierName: "sys_id",
      identifier: id,
    );
    if (addedRecord == null) {
      var response = await provider.getMethod('${APIConstant.userDetail}$id');
      response["sys_id"] = id;
      addToDatabase(
        Constants.tblManagerTaskFEUserDetails,
        FieldEngineerDetailEntity,
        FieldEngineerDetailEntity.fromJson(response),
        identifierName: "sys_id",
        identifier: id,
      );
      return FieldEngineerDetailEntity.fromJson(response);
    }
    return addedRecord;
  }
}
