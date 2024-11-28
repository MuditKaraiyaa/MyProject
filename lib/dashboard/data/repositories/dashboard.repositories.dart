import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/dashboard/data/model/dashboard.model.dart';

abstract class DashboardRepository {
  Future<DashboardResult> getDashboardData();
}

class DashboardRepositoryImpl implements DashboardRepository {
  final APIProvider provider;
  DashboardRepositoryImpl({required this.provider});

  @override
  Future<DashboardResult> getDashboardData() async {
    var addedRecord = await getLocalData(
      Constants.tblMyDashboard,
      DashboardResult,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod(
        userType == UserType.fm
            ? APIConstant.managerDashboardDetails
            : APIConstant.fieldEngineerDashboardDetails,
      );
      addToDatabase(
        Constants.tblMyDashboard,
        DashboardResult,
        DashboardResult.fromJson(response),
      );
      // logger.f(response);
      return DashboardResult.fromJson(response);
    }
    return addedRecord;
  }
}
