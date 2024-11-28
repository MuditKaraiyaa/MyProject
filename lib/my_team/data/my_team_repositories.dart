import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/utils/util.dart';

import '../../main.dart';
import 'model/my_team_entity.dart';

abstract class MyTeamRepository {
  Future<MyTeamEntity> getMyTeamList();
}

class MyTeamRepositoryImpl implements MyTeamRepository {
  final APIProvider provider;
  MyTeamRepositoryImpl({required this.provider});

  @override
  Future<MyTeamEntity> getMyTeamList() async {
    var addedRecord = await getLocalData(Constants.tblMyTeamList, MyTeamEntity);

    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.myTeam);
      logger.i(response.hashCode.toString());
      logger.f(response.toString());
      addToDatabase(
        Constants.tblMyTeamList,
        MyTeamEntity,
        MyTeamEntity.fromJson(response),
      );
      return MyTeamEntity.fromJson(response);
    }
    return addedRecord;
  }
}
