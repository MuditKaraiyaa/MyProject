import 'dart:convert';
import 'dart:io';

import '../../../common/constants/api_constant.dart';
import '../../../common/network/api_provider.dart';
import '../model/diagnostic_entity.dart';

abstract class DiagnosticRepository {
  Future<DiagnosticEntity> uploadTxt({
    required File file,
  });
}

class DiagnosticImpl implements DiagnosticRepository {
  final APIProvider provider;

  DiagnosticImpl({required this.provider});

  @override
  Future<DiagnosticEntity> uploadTxt({
    required File file,
  }) async{

    final response = await provider.uploadAttachment(
      APIConstant.diagnosticAttachment,
      file: file,
    );
    return DiagnosticEntity.fromJson(response);
  }
}
