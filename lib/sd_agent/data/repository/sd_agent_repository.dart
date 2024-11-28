import '../../../common/constants/api_constant.dart';
import '../../../common/network/api_provider.dart';
import '../../../task_details/data/models/case_detail_entity.dart';

abstract class SDAgentRepository {
  Future<CaseDetailEntity?> searchTaskDetail({required String id});
}

class SDAgentRepositoryImpl implements SDAgentRepository {
  final APIProvider provider;
  SDAgentRepositoryImpl({required this.provider});

  @override
  Future<CaseDetailEntity?> searchTaskDetail({required String id}) async {
    final response = await provider.getMethod(APIConstant.caseDetail + id);
    if (response != null) {
      return CaseDetailEntity.fromJson(response);
    }
    return null;
  }
}
