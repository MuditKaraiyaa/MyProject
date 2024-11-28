import 'dart:typed_data';

import 'package:flutter/material.dart';

class CSRModel {
  String? cstRefID;
  String? cstContactID;
  String? startTime;
  String? arrivalTime;
  String? travelTime;
  String? workStartTime;
  String? workEndTime;
  String? departureTime;
  String? customerSatisfy;
  String? missionStatus;
  String? shortDescription;
  TextEditingController? brandTEC;
  TextEditingController? modelTEC;
  TextEditingController? typeTEC;
  TextEditingController? sNumberTEC;
  TextEditingController? descTEC;
  TextEditingController? defectRefTEC;
  TextEditingController? defectPartTEC;
  TextEditingController? defectSNumberTEC;
  TextEditingController? defectTagTEC;
  TextEditingController? replaceRefTEC;
  TextEditingController? replacePartTEC;
  TextEditingController? replaceSNumberTEC;
  TextEditingController? replaceTagTEC;
  TextEditingController? nameTEC;
  TextEditingController? emailTEC;
  TextEditingController? commentTEC;
  TextEditingController? techNameTEC;
  TextEditingController? resolutionNoteTEC;
  Uint8List? customerSign;
  Uint8List? technicianSign;
  String? city;
  String? street;
  String? country;
  String? scheduledDate;
  String? account;
  String? taskNumber;
  String? techName;

  CSRModel({
    required this.cstRefID,
    this.cstContactID,
    this.startTime,
    this.arrivalTime,
    this.travelTime,
    this.workStartTime,
    this.workEndTime,
    this.departureTime,
    this.missionStatus,
    this.customerSatisfy,
    this.shortDescription,
    this.brandTEC,
    this.modelTEC,
    this.typeTEC,
    this.sNumberTEC,
    this.descTEC,
    this.defectRefTEC,
    this.defectPartTEC,
    this.defectSNumberTEC,
    this.defectTagTEC,
    this.replaceRefTEC,
    this.replacePartTEC,
    this.replaceSNumberTEC,
    this.replaceTagTEC,
    this.nameTEC,
    this.emailTEC,
    this.commentTEC,
    this.techNameTEC,
    this.resolutionNoteTEC,
    this.customerSign,
    this.technicianSign,
    this.city,
    this.street,
    this.country,
    this.scheduledDate,
    this.account,
    this.taskNumber,
    required this.techName,
  });
}
